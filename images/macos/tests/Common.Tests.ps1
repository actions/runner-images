Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Disk free space" {
    It "Image has more than 10GB free space" {
        # we should have at least 10 GB of free space on macOS images
        # https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#capabilities-and-limitations
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 10GB
    }
}

Describe "Certificate" {
    It "Apple Worldwide Developer Relations Certification Authority[expired: 2030-02] is installed" {
        $sha1Hash = "06EC06599F4ED0027CC58956B4D3AC1255114F35"
        $certs = security find-certificate -a -c Worldwide -p -Z | Out-String
        $certs | Should -Match $sha1Hash
    }
}

Describe "Git" {
    It "git is installed" {
        "git --version" | Should -ReturnZeroExitCode
    }

    It "git lfs is installed" {
        "git lfs version" | Should -ReturnZeroExitCode
    }

    It "hub CLI is installed" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}

Describe "Audio device" -Skip:($os.IsHighSierra -or $os.IsBigSur) {
    It "Sox is installed" {
        "sox --version" | Should -ReturnZeroExitCode
    }

    It "SwitchAudioSource is installed" {
        "SwitchAudioSource -c" | Should -ReturnZeroExitCode
    }

    It "Audio channel Soundflower (2ch)" {
        SwitchAudioSource -c | Should -BeLikeExactly "Soundflower (2ch)"
    }
}

Describe "CommonUtils" {
    It "Carthage" {
        "carthage version" | Should -ReturnZeroExitCode
    }

    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }

    It "Subversion" {
        "svn --version" | Should -ReturnZeroExitCode
    }

    It "Go" {
        "go version" | Should -ReturnZeroExitCode
    }

    It "GnuPG" {
        "gpg --version" | Should -ReturnZeroExitCode
    }

    It "Clang/LLVM is installed" {
        "$(brew --prefix llvm)/bin/clang --version" | Should -ReturnZeroExitCode
    }

    It "zstd" {
        "zstd --version" | Should -ReturnZeroExitCode
    }

    It "Packer" {
        "packer --version" | Should -ReturnZeroExitCode
    }

    It "Perl" {
        "perl -e 'print substr($^V,1)'" | Should -ReturnZeroExitCode
    }

    It "Helm" {
        "helm version --short" | Should -ReturnZeroExitCode
    }

    It "bazelisk" {
        "bazelisk version" | Should -ReturnZeroExitCode
    }

    It "GitHub CLI" {
        "gh --version" | Should -ReturnZeroExitCode
    }

    It "7-Zip" {
        "7z i" | Should -ReturnZeroExitCode
    }

    It "Apache Ant" {
        "ant -version" | Should -ReturnZeroExitCode
    }

    It "Aria2" {
        "aria2c --version" | Should -ReturnZeroExitCode
    }

    It "GNU Tar" {
        "gtar --version" | Should -ReturnZeroExitCode
    }

    It "bazel" {
        "bazel --version" | Should -ReturnZeroExitCode
    }

    It "Aliyun CLI" {
        "aliyun --version" | Should -ReturnZeroExitCode
    }

    It "Julia" {
        "julia --version" | Should -ReturnZeroExitCode
    }

    It "jq" {
        "jq --version" | Should -ReturnZeroExitCode
    }

    It "curl" {
        "curl --version" | Should -ReturnZeroExitCode
    }

    It "wget" {
        "wget --version" | Should -ReturnZeroExitCode
    }

    It "vagrant" -Skip:($os.IsBigSur) {
        "vagrant --version" | Should -ReturnZeroExitCode
    }

    It "virtualbox" -Skip:($os.IsBigSur) {
        "vboxmanage -v" | Should -ReturnZeroExitCode
    }

    It "xctool" -Skip:($os.IsBigSur) {
        "xctool --version" | Should -ReturnZeroExitCode
    }

    It "R" -Skip:($os.IsBigSur) {
        "R --version" | Should -ReturnZeroExitCode
    }
}

Describe ".NET" {
    It ".NET" {
        "dotnet --version" | Should -ReturnZeroExitCode
    }
}

Describe "Homebrew" {
    It "Homebrew" {
        "brew --version" | Should -ReturnZeroExitCode
    }
}

Describe "GCC" -Skip:($os.IsHighSierra) {
    $testCases = @("8", "9", "10") | ForEach-Object { @{Version = $_} }

    It "GCC <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gcc-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gfortran-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran is not found in the default path" {
        "$(which gfortran)" | Should -BeNullOrEmpty
    }
}

Describe "Screen Resolution" -Skip:($os.IsHighSierra) {
    It "Screen Resolution" {
        system_profiler SPDisplaysDataType | Select-String "Resolution" | Should -Match "1176 x 885"
    }
}

Describe "vcpkg" -Skip:($os.IsHighSierra -or $os.IsMojave) {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}

Describe "Newman" -Skip:($os.IsHighSierra -or $os.IsMojave) {
    It "Newman" {
        "newman --version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }
    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }

    It "AWS Session Manager CLI" {
        "session-manager-plugin --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzureCLI" {
    It "Azure CLI" {
        "az -v" | Should -ReturnZeroExitCode
    }
}

Describe "Miniconda" {
    It "Conda" {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }
}

Describe "AppCenterCLI" {
    It "App Center CLI" {
        "appcenter --version" | Should -ReturnZeroExitCode
    }
}

Describe "OpenSSL" {
    It "OpenSSL is available" {
        "openssl version" | Should -ReturnZeroExitCode
    }

    It "OpenSSL 1.1 path exists" {
        $openSSLpath = "/usr/local/opt/openssl@1.1"
        $openSSLpath | Should -Exist
    }

    It "Default OpenSSL version is 1.1" {
        $commandResult = Get-CommandResult "openssl version"
        $commandResult.Output | Should -Match "OpenSSL 1.1"
    }
}

Describe "Stack" -Skip:($os.IsHighSierra) {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "VSMac" {
    It "VS4Mac is installed" {
        $vsPath = "/Applications/Visual Studio.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }
}