function Get-CommandResult {
    Param (
        [Parameter(Mandatory)][string] $Command,
        [switch] $Multiline
    )
    $exitCode = $LASTEXITCODE
    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

# Gets path to the tool, analogue of 'which tool'
function Get-WhichTool {
    Param (
        [Parameter(Mandatory)][string] $Tool
    )
    return (Get-Command $Tool).Path
}

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}

function Update-Environment {
    $variables = [Environment]::GetEnvironmentVariables("Machine")
    $variables.Keys | ForEach-Object {
        $key = $_
        $value = $variables[$key]
        Set-Item -Path "env:$key" -Value $value
    }
    # We need to refresh PATH the latest one because it could include other variables "%M2_HOME%/bin"
    $env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
}

function Invoke-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testsDirectory = Join-Path "C:\image" "Tests"
    $testPath = Join-Path $testsDirectory "${TestFile}.Tests.ps1"

    if (-not (Test-Path $testPath)) {
        # TO-DO: Make sure that throw will fail packer build
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    Update-Environment
    Invoke-Pester -Script $testPath -TestName $TestName -EnableExit
}

function ShouldReturnZeroExitCode {
    Param(
        [Parameter (Mandatory = $true)] [ValidateNotNullOrEmpty()]
        [String]$ActualValue,
        [switch]$Negate
    )

    [string[]]$output = Invoke-Expression -Command $ActualValue
    $actualExitCode = $LASTEXITCODE

    [bool]$succeeded = $actualExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        # log detailed output in case of fail
        Write-Host "Run command '${ActualValue}'"
        $output | ForEach-Object { Write-Host $_ }
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}"
    }

    return New-Object PSObject -Property @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

If (Get-Command -Name Add-AssertionOperator -ErrorAction SilentlyContinue) {
    Add-AssertionOperator -Name ReturnZeroExitCode -Test $function:ShouldReturnZeroExitCode
}

# TO-DO: Need to validate that ImageHelpers scripts are deleted from image at the end of image-generation