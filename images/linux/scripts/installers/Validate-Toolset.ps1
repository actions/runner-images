################################################################################
##  File:  Validate-Toolset.ps1
##  Desc:  Validate Toolset
################################################################################

function Get-ToolsByName {
    param (
        [Parameter(Mandatory)] [string]$SoftwareName
    )

    $tools = Get-Content -Raw $env:TOOLSET_JSON_PATH | ConvertFrom-Json
    return $tools.PSObject.Properties.Value | Where-Object { $_.name -eq $SoftwareName }
}

function Run-TestsByPath {
    param (
        [Parameter(Mandatory)] [string[]]$ExecTests,
        [Parameter(Mandatory)] [string]$TestsDirectoryPath,
        [Parameter(Mandatory)] [string]$SoftwareName,
        [Parameter(Mandatory)] [string]$SoftwareVersion
    )

    foreach ($test in $ExecTests)
    {
        if (-not (Test-Path "$TestsDirectoryPath/$test"))
        {
            Write-Host "$SoftwareName($test) $SoftwareVersion is not installed"
            exit 1
        }

        Write-Host "$SoftwareName($test) $SoftwareVersion is successfully installed:"
        & "$TestsDirectoryPath/$test" --version
    }
}

function Get-MarkdownDescription {
    param (
        [Parameter(Mandatory)] [string]$SoftwareVersion
    )
    return "  - $SoftwareVersion<br/>"
}

function Get-DefaultPythonDescription {
    param (
        [Parameter(Mandatory)] [array]$Tools
    )

    $defaultPythonVersion = Invoke-Expression "python --version"
    $defaultPipVersion = Invoke-Expression "pip --version"

    $defaultPython3Version = Invoke-Expression "python3 --version"
    $defaultPip3Version = Invoke-Expression "pip3 --version"

    $pythonBinOnPath = Split-Path -Path (Get-Command -Name 'python').Path
    $description = "  - __System default versions:__<br/>"
    $description += "  - python ($defaultPythonVersion)<br/>"
    $description += "  - pip ($defaultPipVersion)<br/>"
    $description += "  - python3 ($defaultPython3Version)<br/>"
    $description += "  - pip3 ($defaultPip3Version)<br/>"
    return $description
}

function Run-ToolsetTests {
    param (
        [Parameter(Mandatory)] [string]$SoftwareName,
        [Parameter(Mandatory)] [string[]]$ExecTests
    )

    $softwarePath = Join-Path $env:AGENT_TOOLSDIRECTORY $SoftwareName
    if (-Not (Test-Path $softwarePath))
    {
        Write-Host "$softwarePath does not exist"
        exit 1
    }

    [array]$installedVersions = Get-ChildItem -Path $softwarePath -Directory -Name
    if ($installedVersions.count -eq 0)
    {
        Write-Host "$softwarePath does not include any folders"
        exit 1
    }

    $markdownDescription = ""
    [array]$tools = Get-ToolsByName -SoftwareName $SoftwareName

    foreach($tool in $tools)
    {
        $markdownDescription += "- $($SoftwareName):</br>"
        foreach ($version in $tool.versions)
        {
            $foundVersion = $installedVersions | Where-Object { $_ -like $version }
            if ($foundVersion -eq $null)
            {
                Write-Host "$softwarePath/$version was not found"
                exit 1
            }

            $testsDirectoryPath = "$softwarePath/$foundVersion/x64"
            Run-TestsByPath -ExecTests $ExecTests `
                            -TestsDirectoryPath $testsDirectoryPath `
                            -SoftwareName $SoftwareName `
                            -SoftwareVersion $foundVersion `

            $markdownDescription += Get-MarkdownDescription -SoftwareVersion $foundVersion `
        }
    }

    if ($SoftwareName -eq "Python") {
        $markdownDescription += Get-DefaultPythonDescription -Tools $tools
    }

    Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $markdownDescription
}

# Python test
$PythonTests = @("python", "bin/pip")
Run-ToolsetTests -SoftwareName "Python" -ExecTests $PythonTests