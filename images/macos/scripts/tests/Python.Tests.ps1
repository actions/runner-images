Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Python3" {
    It "Python 3 is available" {
        "python3 --version" | Should -ReturnZeroExitCode
    }
    
    if ($os.IsArm64) {
        It "Python 3 is installed under /opt/homebrew/bin/" {
            Get-ToolPath "python3" | Should -BeLike "/opt/homebrew/bin/*"
        }
    } else {
        It "Python 3 is installed under /usr/local/bin" {
            Get-ToolPath "python3" | Should -BeLike "/usr/local/bin*"
        }
    }

    It "Pip 3 is available" {
        "pip3 --version" | Should -ReturnZeroExitCode
    }

    It "Pipx is available" {
        "pipx --version" | Should -ReturnZeroExitCode
    }

    It "Pip 3 and Python 3 came from the same brew formula" {
        $pip3Path = Split-Path (readlink (which pip3))
        $python3Path = Split-Path (readlink (which python3))
        $pip3Path | Should -BeExactly $python3Path
    }

}
