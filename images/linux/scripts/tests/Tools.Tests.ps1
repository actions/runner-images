Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "azcopy" {
    It "azcopy" {
        #(azcopy --version) command returns exit code 1 (see details: https://github.com/Azure/azure-storage-azcopy/releases)
        $azcopyVersion = (Get-CommandResult "azcopy --version").Output
        $azcopyVersion | Should -BeLike "*azcopy*"
    }

    It "azcopy10" {
        "azcopy10 --version" | Should -ReturnZeroExitCode
    }
}

Describe "Docker" {
    It "docker" {
        "docker --version" | Should -ReturnZeroExitCode
    }

    It "docker buildx" {
        "docker buildx" | Should -ReturnZeroExitCode
    }

    Context "docker images" {
        $testCases = (Get-ToolsetContent).docker.images | ForEach-Object { @{ ImageName = $_ } }

        It "<ImageName>" -TestCases $testCases {
           sudo docker images "$ImageName" --format "{{.Repository}}" | Should -Not -BeNullOrEmpty
        }
    }
}

Describe "Docker-compose" {
    It "docker-compose" {
        "docker-compose --version"| Should -ReturnZeroExitCode
    }
}

Describe "PowerShell Core" {
    It "pwsh" {
        "pwsh --version" | Should -ReturnZeroExitCode
    }

    It "Execute 2+2 command" {
        pwsh -Command "2+2" | Should -BeExactly 4
    }
}

Describe "Ansible" {
    It "Ansible" {
        "ansible --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bazel" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bazel" }
        @{ ToolName = "bazelisk" }
    ) {
        "$ToolName --version"| Should -ReturnZeroExitCode
    }
}

Describe "clang" {
    [array]$testCases = (Get-ToolsetContent).clang.Versions | ForEach-Object { @{ClangVersion = $_} }

    It "clang <ClangVersion>" -TestCases $testCases {
        param (
            [string] $ClangVersion
        )

        "clang-$ClangVersion --version" | Should -ReturnZeroExitCode
        "clang++-$ClangVersion --version" | Should -ReturnZeroExitCode
    }   
}

Describe "Cmake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "erlang" {
    $testCases = @("erl", "erlc", "rebar3") | ForEach-Object { @{ErlangCommand = $_} }

    It "erlang <ErlangCommand>" -TestCases $testCases {
        param (
            [string] $ErlangCommand
        )

        "$ErlangCommand -v" | Should -ReturnZeroExitCode
    }   
}

Describe "gcc" {
    [array]$testCases = (Get-ToolsetContent).gcc.Versions | ForEach-Object { @{GccVersion = $_} }

    It "gcc <GccVersion>" -TestCases $testCases {
        param (
            [string] $GccVersion
        )

        "$GccVersion --version" | Should -ReturnZeroExitCode
    }
}

Describe "gfortran" {
    [array]$testCases = (Get-ToolsetContent).gfortran.Versions | ForEach-Object { @{GfortranVersion = $_} }

    It "gfortran <GfortranVersion>" -TestCases $testCases {
        param (
            [string] $GfortranVersion
        )

        "$GfortranVersion --version" | Should -ReturnZeroExitCode
    }
}

Describe "Mono" {
    It "mono" {
        "mono --version" | Should -ReturnZeroExitCode
    }

    It "nuget" {
        "nuget" | Should -ReturnZeroExitCode
    }
}

Describe "MSSQLCommandLineTools" {
    It "sqlcmd" {
        "sqlcmd -?" | Should -ReturnZeroExitCode
    }
}

Describe "R" {
    It "r" {
        "R --version" | Should -ReturnZeroExitCode
    }
}

Describe "Sbt" {
    It "sbt" {
        "sbt --version" | Should -ReturnZeroExitCode
    }
}

Describe "Sphinx" {
    It "sphinx" {
        "searchd -h" | Should -ReturnZeroExitCode
    }
}

Describe "Selenium" {
    It "Selenium Server 'selenium-server-standalone.jar' is installed" {
        "/usr/share/java/selenium-server-standalone.jar" | Should -Exist
    }
}

Describe "SVN" {
    It "svn" {
        "svn --version" | Should -ReturnZeroExitCode
    }
}

Describe "Swig" {
    It "swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "Terraform" {
    It "terraform" {
        "terraform --version" | Should -ReturnZeroExitCode
    }
}

Describe "Vcpkg" {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}
