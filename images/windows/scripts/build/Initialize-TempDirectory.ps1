################################################################################
##  File:  Initialize-TempDirectory.ps1
##  Desc:  Prepare and validate the temporary directory before image provisioning
################################################################################

$ErrorActionPreference = "Stop"

if ($env:TEMP_DIR -notmatch '^[A-Za-z]:\\.+') {
    throw "TEMP_DIR must be an absolute directory path below a local drive root. Received '$env:TEMP_DIR'."
}

$tempDirectory = [System.IO.Path]::GetFullPath($env:TEMP_DIR)
if ($tempDirectory.TrimEnd('\') -eq [System.IO.Path]::GetPathRoot($tempDirectory).TrimEnd('\')) {
    throw "TEMP_DIR must be below the drive root. Received '$env:TEMP_DIR'."
}

$driveLetter = $env:TEMP_DIR.Substring(0, 1).ToUpperInvariant()
$volumes = @(Get-Volume)
$volume = $volumes | Where-Object { $_.DriveLetter -eq $driveLetter }

if (-not ($volume -and $volume.DriveType -eq "Fixed" -and $volume.FileSystem)) {
    if ($driveLetter -ne "D") {
        throw "TEMP_DIR '$env:TEMP_DIR' is not on an initialized fixed volume. Prepare the selected drive before building."
    }

    # Azure presents local NVMe disks as RAW; never initialize remote NVMe or OS disks.
    # https://learn.microsoft.com/azure/virtual-machines/enable-nvme-temp-faqs
    $tempDisks = @(Get-Disk | Where-Object {
        $_.FriendlyName -like "Microsoft NVMe Direct Disk*" -and
        $_.BusType -eq "NVMe" -and -not $_.IsBoot -and -not $_.IsSystem
    })
    if ($tempDisks.Count -ne 1) {
        throw "Drive D: is not an initialized fixed volume. Expected exactly one Azure local NVMe disk, found $($tempDisks.Count). Prepare the temporary volume or override temp_dir with an existing writable fixed volume."
    }

    $disk = $tempDisks[0]
    if ($disk.PartitionStyle -ne "RAW" -or $disk.IsReadOnly -or $disk.IsOffline -or $disk.IsClustered -or
        $disk.HealthStatus -ne "Healthy" -or $disk.OperationalStatus -notcontains "Online" -or
        $disk.NumberOfPartitions -ne 0) {
        throw "Refusing to initialize disk '$($disk.FriendlyName)' (number $($disk.Number)): it must be healthy, online, writable, RAW, and contain no partitions."
    }

    $logicalDisks = @(Get-CimInstance -ClassName Win32_LogicalDisk)
    $drive = $logicalDisks | Where-Object { $_.DeviceID -eq "D:" }
    if ($drive -and $drive.DriveType -ne 5) {
        throw "Drive D: is occupied by a non-CD-ROM device. No drive letters or disks have been changed."
    }
    if ($volume -and $volume.DriveType -ne "CD-ROM") {
        throw "Drive D: is occupied by an unusable volume. No drive letters or disks have been changed."
    }

    if ($drive) {
        $occupiedLetters = @($logicalDisks | ForEach-Object { $_.DeviceID.Substring(0, 1) })
        $occupiedLetters += @($volumes | ForEach-Object { [string] $_.DriveLetter })
        $occupiedLetters += @(Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Name)
        $cdromLetter = 69..90 | ForEach-Object { [string][char] $_ } |
            Where-Object { $_ -notin $occupiedLetters } | Select-Object -First 1
        if (-not $cdromLetter) {
            throw "Cannot free drive D: because no drive letter from E: to Z: is available for the CD-ROM."
        }

        Write-Host "Moving the CD-ROM from D: to ${cdromLetter}:"
        $diskpartScript = [System.IO.Path]::GetTempFileName()
        try {
            Set-Content -LiteralPath $diskpartScript -Encoding ASCII -Value "select volume D`r`nassign letter=$cdromLetter`r`nexit"
            diskpart.exe /s $diskpartScript
            if ($LASTEXITCODE -ne 0) {
                throw "DiskPart failed to reassign the CD-ROM, exit code $LASTEXITCODE."
            }
        } finally {
            Remove-Item -LiteralPath $diskpartScript -Force
        }

        # DiskPart can report errors without a nonzero exit code.
        $logicalDisks = @(Get-CimInstance -ClassName Win32_LogicalDisk)
        $cdrom = $logicalDisks | Where-Object { $_.DeviceID -eq "${cdromLetter}:" -and $_.DriveType -eq 5 }
        if (($logicalDisks | Where-Object { $_.DeviceID -eq "D:" }) -or -not $cdrom) {
            throw "The CD-ROM was not successfully moved from D: to ${cdromLetter}:. The NVMe disk has not been initialized."
        }
    }

    Write-Host "Initializing Azure local NVMe disk $($disk.Number) as D:"
    Initialize-Disk -UniqueId $disk.UniqueId -PartitionStyle GPT
    New-Partition -DiskId $disk.UniqueId -DriveLetter D -UseMaximumSize |
        Format-Volume -FileSystem NTFS -NewFileSystemLabel "Temporary Storage" -Confirm:$false | Out-Null

    $partition = Get-Partition -DriveLetter D
    if ($partition.DiskNumber -ne $disk.Number) {
        throw "Drive D: does not belong to the selected Azure local NVMe disk."
    }
}

$volume = Get-Volume -DriveLetter $driveLetter
if ($volume.DriveType -ne "Fixed" -or -not $volume.FileSystem -or $volume.HealthStatus -ne "Healthy") {
    throw "TEMP_DIR '$env:TEMP_DIR' is not on a healthy, initialized fixed volume."
}

Write-Host "Validating read/write access to '$env:TEMP_DIR'"
New-Item -Path $env:TEMP_DIR -ItemType Directory -Force | Out-Null
$probeValue = [guid]::NewGuid().ToString()
$probePath = Join-Path $env:TEMP_DIR "runner-images-write-test-$probeValue.tmp"
$probeCreated = $false
try {
    New-Item -Path $probePath -ItemType File -Value $probeValue | Out-Null
    $probeCreated = $true
    if ((Get-Content -LiteralPath $probePath -Raw) -ne $probeValue) {
        throw "Read/write validation failed for TEMP_DIR '$env:TEMP_DIR'."
    }
} finally {
    if ($probeCreated) {
        Remove-Item -LiteralPath $probePath -Force
    }
}
