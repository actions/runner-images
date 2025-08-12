Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Azure CLI" {
    It "Azure CLI" {
        "az -v" | Should -ReturnZeroExitCode
    }
}

Describe "Azure DevOps CLI" {
    It "az devops" {
        "az devops -h" | Should -ReturnZeroExitCode
    }
}

Describe "Carthage" {
    It "Carthage" {
        "carthage version" | Should -ReturnZeroExitCode
    }
}

Describe "cmake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "SwiftFormat" {
    It "SwiftFormat" {
        "swiftformat --version" | Should -ReturnZeroExitCode
    }
}

Describe "GnuPG" {
    It "GnuPG" {
        "gpg --version" | Should -ReturnZeroExitCode
    }
}

Describe "zstd" {
    It "zstd" {
        "zstd --version" | Should -ReturnZeroExitCode
    }
}

Describe "Packer" {
    It "Packer" {
        "packer --version" | Should -ReturnZeroExitCode
    }
}

Describe "Perl" {
    It "Perl" {
        "perl -e 'print substr($^V,1)'" | Should -ReturnZeroExitCode
    }
}

Describe "Tcl/Tk" -Skip:(-not ($os.IsVenturaX64 -or $os.IsSonomaX64)) {
    It "libtcl" {
        Test-Path "/usr/local/lib/libtcl8.6.dylib" | Should -BeTrue
        Test-Path "/usr/local/lib/libtk8.6.dylib" | Should -BeTrue
    }
}

Describe "bazelisk" {
    It "bazelisk" {
        "bazelisk version" | Should -ReturnZeroExitCode
    }
}

Describe "Github CLI" {
    It "GitHub CLI" {
        "gh --version" | Should -ReturnZeroExitCode
    }
}

Describe "7-Zip" {
    It "7-Zip" {
        "7z i" | Should -ReturnZeroExitCode
    }
}

Describe "Apache Ant" {
    It "Apache Ant" {
        "ant -version" | Should -ReturnZeroExitCode
    }
}

Describe "Aria2" {
    It "Aria2" {
        "aria2c --version" | Should -ReturnZeroExitCode
    }
}

Describe "GNU Tar" {
    It "GNU Tar" {
        "gtar --version" | Should -ReturnZeroExitCode
    }
}

Describe "bazel" {
    It "bazel" {
        "bazel --version" | Should -ReturnZeroExitCode
    }
}

Describe "jq" {
    It "jq" {
        "jq --version" | Should -ReturnZeroExitCode
    }
}

Describe "curl" {
    It "curl" {
        "curl --version" | Should -ReturnZeroExitCode
    }
}

Describe "wget" {
    It "wget" {
        "wget --version" | Should -ReturnZeroExitCode
    }
}

Describe "Homebrew" {
    It "Homebrew" {
        "brew --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kotlin" {
    $kotlinPackages = @("kapt", "kotlin", "kotlinc", "kotlinc-jvm", "kotlinc-js")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object { @{ toolName = $_ } }) {
        "$toolName -help" | Should -ReturnZeroExitCode
    }
}

Describe "yq" {
    It "yq" {
        "yq --version" | Should -ReturnZeroExitCode
    }
}

Describe "pkgconf" {
    It "pkgconf" {
        "pkgconf --version" | Should -ReturnZeroExitCode
    }
}

Describe "Ninja" {
    New-item -Path "/tmp/ninjaproject" -ItemType Directory -Force
    Set-Location '/tmp/ninjaproject'
@'
cmake_minimum_required(VERSION 3.10)
project(NinjaTest NONE)
'@ | Out-File -FilePath "./CMakeLists.txt"

    It "Make a simple ninja project" {
    "cmake -GNinja /tmp/ninjaproject" | Should -ReturnZeroExitCode
    }

    It "build.ninja file should exist" {
        $buildFilePath = Join-Path "/tmp/ninjaproject" "build.ninja"
        $buildFilePath | Should -Exist
    }

    It "Ninja" {
        "ninja --version" | Should -ReturnZeroExitCode
    }
}
