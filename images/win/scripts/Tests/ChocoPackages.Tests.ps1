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

Describe "GitVersion" -Skip:(Test-IsWin22) {
    It "gitversion is installed" {
        "gitversion /version" | Should -ReturnZeroExitCode
    }
}

Describe "InnoSetup" {
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

Describe "OpenSSL" {
    It "OpenSSL" {
       "openssl version" | Should -ReturnZeroExitCode
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

Describe "Svn" {
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