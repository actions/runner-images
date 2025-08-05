Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "Aria2" {
    It "Aria2" {
        "aria2c --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "GitVersion" -Skip:(-not (Test-IsWin19)) {
    It "gitversion is installed" {
        "gitversion /version" | Should -ReturnZeroExitCode
    }
}

Describe "InnoSetup" -Skip:(Test-IsWin25) {
    It "InnoSetup" {
        (Get-Command -Name iscc).CommandType | Should -BeExactly "Application"
    }
}

Describe "Jq" {
    It "Jq" {
        "jq -n ." | Should -ReturnZeroExitCode
    }
}

Describe "Nuget" {
    It "Nuget" {
       "nuget" | Should -ReturnZeroExitCode
    }
}

Describe "Packer" {
    It "Packer" {
       "packer --version" | Should -ReturnZeroExitCode
    }
}

Describe "Perl" {
    It "Perl" {
       "perl --version" | Should -ReturnZeroExitCode
    }
}

Describe "Pulumi" {
    It "pulumi" {
       "pulumi version" | Should -ReturnZeroExitCode
    }
}

Describe "Svn" -Skip:(Test-IsWin25) {
    It "svn" {
        "svn --version --quiet" | Should -ReturnZeroExitCode
    }
}

Describe "Swig" {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "VSWhere" {
    It "vswhere" {
        "vswhere" | Should -ReturnZeroExitCode
    }
}

Describe "Julia" {
    It "Julia path exists" {
        "C:\Julia" | Should -Exist
    }

    It "Julia" {
        "julia --version" | Should -ReturnZeroExitCode
    }
}

Describe "CMake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "ImageMagick" {
    It "ImageMagick" {
        "magick -version" | Should -ReturnZeroExitCode
    }
}

Describe "Ninja" {
    BeforeAll {
        $ninjaProjectPath = $(Join-Path $env:TEMP_DIR "ninjaproject")
        New-item -Path $ninjaProjectPath -ItemType Directory -Force
@'
cmake_minimum_required(VERSION 3.10)
project(NinjaTest NONE)
'@ | Out-File -FilePath "$ninjaProjectPath/CMakeLists.txt" -Encoding utf8

        $ninjaProjectBuildPath = $(Join-Path $ninjaProjectPath "build")
        New-item -Path $ninjaProjectBuildPath -ItemType Directory -Force
        Set-Location $ninjaProjectBuildPath
    }

    It "Make a simple ninja project" {
    "cmake -GNinja $ninjaProjectPath" | Should -ReturnZeroExitCode
    }

    It "build.ninja file should exist" {
        $buildFilePath = $(Join-Path $ninjaProjectBuildPath "build.ninja")
        $buildFilePath | Should -Exist
    }

    It "Ninja" {
        "ninja --version" | Should -ReturnZeroExitCode
    }
}
