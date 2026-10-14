$ErrorActionPreference = 'Stop'

enum ImageType {
    Ubuntu2204_Amd64_Lxd = 1
    Ubuntu2204_Amd64_Vm
    Ubuntu2204_Amd64_Docker
    Ubuntu2204_Arm64_Lxd
    Ubuntu2204_Arm64_Docker
    Ubuntu2404_Amd64_Lxd
    Ubuntu2404_Amd64_Vm
    Ubuntu2404_Amd64_Docker
    Ubuntu2404_Arm64_Lxd
    Ubuntu2404_Arm64_Docker
    Ubuntu2604_Amd64_Lxd
    Ubuntu2604_Amd64_Vm
    Ubuntu2604_Amd64_Docker
    Ubuntu2604_Arm64_Lxd
    Ubuntu2604_Arm64_Docker
    Windows2022_Amd64_Docker
    Windows2025_Amd64_Docker
    Windows2025_Vs2026_Amd64_Docker
    Windows11_Arm64_Docker
    Windows11_Vs2026_Arm64_Docker
}

Function Get-PackerTemplate {
    param (
        [Parameter(Mandatory = $True)]
        [string] $RepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType
    )

    switch -Wildcard ($ImageType.ToString()) {
        'Ubuntu2204_Amd64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-22_04.pkr.hcl'
            $imageOS = 'ubuntu22'
        }
        'Ubuntu2204_Arm64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-22_04-arm64.pkr.hcl'
            $imageOS = 'ubuntu22-arm64'
        }
        'Ubuntu2404_Amd64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-24_04.pkr.hcl'
            $imageOS = 'ubuntu24'
        }
        'Ubuntu2404_Arm64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-24_04-arm64.pkr.hcl'
            $imageOS = 'ubuntu24-arm64'
        }
        'Ubuntu2604_Amd64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-26_04.pkr.hcl'
            $imageOS = 'ubuntu26'
        }
        'Ubuntu2604_Arm64_*' {
            $relativeTemplatePath = Join-Path 'ubuntu/templates' 'build.ubuntu-26_04-arm64.pkr.hcl'
            $imageOS = 'ubuntu26-arm64'
        }
        'Windows2022_Amd64_*' {
            $relativeTemplatePath = Join-Path 'windows/templates' 'build.windows-2022.pkr.hcl'
            $imageOS = 'win22'
        }
        'Windows2025_Amd64_*' {
            $relativeTemplatePath = Join-Path 'windows/templates' 'build.windows-2025.pkr.hcl'
            $imageOS = 'win25'
        }
        'Windows2025_Vs2026_Amd64_*' {
            $relativeTemplatePath = Join-Path 'windows/templates' 'build.windows-2025-vs2026.pkr.hcl'
            $imageOS = 'win25-vs2026'
        }
        'Windows11_Arm64_*' {
            $relativeTemplatePath = Join-Path 'windows/templates' 'build.windows-11-arm64.pkr.hcl'
            $imageOS = 'win11-arm64'
        }
        'Windows11_Vs2026_Arm64_*' {
            $relativeTemplatePath = Join-Path 'windows/templates' 'build.windows-11-vs2026-arm64.pkr.hcl'
            $imageOS = 'win11-vs2026-arm64'
        }
        default { throw "Unknown type of image '$ImageType'." }
    }
    switch -Wildcard ($ImageType.ToString()) {
        '*_lxd' { $backend = 'lxd'; $instanceType = 'container' }
        '*_vm' { $backend = 'lxd'; $instanceType = 'vm' }
        '*_docker' { $backend = 'docker'; $instanceType = 'container' }
    }

    $imageTemplatePath = [IO.Path]::Combine($RepositoryRoot, "images", $relativeTemplatePath)
    # Specific template selection using Packer's "-only" functionality
    $buildName = [IO.Path]::GetFileName($imageTemplatePath).Split(".")[1]

    if (-not (Test-Path $imageTemplatePath)) {
        throw "Template for image '$ImageType' doesn't exist on path '$imageTemplatePath'."
    }
    $sourceName = if ($backend -eq 'docker') { '*' } else { $instanceType }
    return [PSCustomObject] @{
        BuildName    = $buildName
        ImageOS      = $imageOS
        Path         = [IO.Path]::GetDirectoryName($imageTemplatePath)
        Backend      = $backend
        InstanceType = $instanceType
        Source       = "$buildName.$backend.$sourceName"
        IsWindows    = $imageOS.StartsWith('win')
    }
}

Function Show-LatestCommit {
    [CmdletBinding()]
    param()

    process {
        $latestCommit = (git --no-pager log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1)
        Write-Host "Latest commit: $latestCommit."
    }
}

Function GenerateResourcesAndImage {
    <#
        .SYNOPSIS
            A helper function to help generate an image.
        .DESCRIPTION
            Build an LXD or Docker image of the specified image type with Packer.
        .PARAMETER ImageType
            ImageType enum value, e.g. Ubuntu2604_Amd64_Lxd.
        .PARAMETER ImageGenerationRepositoryRoot
            The root directory of the image generation repository. This is used to locate the packer template.
        .PARAMETER OnError
            Specify how packer handles an error during image creation.
            Options:
                abort - abort immediately
                ask - ask user for input
                cleanup - attempt to cleanup and then abort
                run-cleanup-provisioner - run the cleanup provisioner and then abort
            The default is 'ask'.
        .EXAMPLE
            GenerateResourcesAndImage -ImageGenerationRepositoryRoot "$HOME/runner-images" -ImageType Ubuntu2204_Amd64_Vm
    #>
    param (
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType,
        [Parameter(Mandatory = $False)]
        [string] $ImageGenerationRepositoryRoot = $pwd,
        [Parameter(Mandatory = $False)]
        [ValidateSet("abort", "ask", "cleanup", "run-cleanup-provisioner")]
        [string] $OnError = "ask"
    )

    Show-LatestCommit -ErrorAction SilentlyContinue

    # Validate packer is installed
    $PackerBinary = Get-Command "packer"
    if (-not ($PackerBinary)) {
        throw "'packer' binary is not found on PATH."
    }

    # Get template path
    $PackerTemplate = Get-PackerTemplate -RepositoryRoot $ImageGenerationRepositoryRoot -ImageType $ImageType
    Write-Debug "Template path: $($PackerTemplate.Path)."

    $source = $PackerTemplate.Source

    $InstallPassword = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()

    Write-Host "Downloading packer plugins..."
    & $PackerBinary init $PackerTemplate.Path

    if ($LastExitCode -ne 0) {
        throw "Packer plugins download failed."
    }

    Write-Host "Validating packer template..."
    & $PackerBinary validate `
        "-only=$source" `
        "-var=image_os=$($PackerTemplate.ImageOS)" `
        "-var=install_password=$($InstallPassword)" `
        $PackerTemplate.Path

    if ($LastExitCode -ne 0) {
        throw "Packer template validation failed."
    }

    try {
        & $PackerBinary build -on-error="$($OnError)" `
            -only $source `
            -var "image_os=$($PackerTemplate.ImageOS)" `
            -var "install_password=$($InstallPassword)" `
            $PackerTemplate.Path

        if ($LastExitCode -ne 0) {
            throw "Failed to build image."
        }
    } catch {
        Write-Error $_
    }
}
