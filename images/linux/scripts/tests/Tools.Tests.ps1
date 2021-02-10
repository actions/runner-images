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

Describe "Rust" {
    It "Rustup is installed" {
        "rustup --version" | Should -ReturnZeroExitCode
    }

    It "Rustc is installed" {
        "rustc --version" | Should -ReturnZeroExitCode
    }

    It "Rustdoc is installed" {
        "rustdoc --version" | Should -ReturnZeroExitCode
    }

    It "Rustfmt is installed" {
        "rustfmt --version" | Should -ReturnZeroExitCode
    }

    Context "Cargo dependencies" {
        It "bindgen" {
            "bindgen --version" | Should -ReturnZeroExitCode
        }

        It "cbindgen" {
            "cbindgen --version" | Should -ReturnZeroExitCode
        }

        It "cargo" {
            "cargo --version" | Should -ReturnZeroExitCode
        }

        It "cargo-clippy" {
            "cargo-clippy --version" | Should -ReturnZeroExitCode
        }

        It "Cargo audit" {
            "cargo audit --version" | Should -ReturnZeroExitCode
        }

        It "Cargo outdated" {
            "cargo outdated --version" | Should -ReturnZeroExitCode
        }
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

Describe "Selenium" {
    It "Selenium Server 'selenium-server-standalone.jar' is installed" {
        "/usr/share/java/selenium-server-standalone.jar" | Should -Exist
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

Describe "Git" {
    It "git" {
        "git --version" | Should -ReturnZeroExitCode
    }

    It "git-lfs" {
        "git-lfs --version" | Should -ReturnZeroExitCode
    }

    It "git-ftp" {
        "git-ftp --version" | Should -ReturnZeroExitCode
    }

    It "hub-cli" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}

Describe "Heroku" {
    It "heroku" {
        "heroku --version" | Should -ReturnZeroExitCode
    }
}

Describe "HHVM" {
    It "hhvm" {
        "hhvm --version" | Should -ReturnZeroExitCode
    }
}

Describe "Homebrew" {
    It "homebrew" {
        "brew --version" | Should -ReturnZeroExitCode
    }
}

Describe "Julia" {
    It "julia" {
        "julia --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kubernetes tools" {
    It "kind" {
        "kind --version" | Should -ReturnZeroExitCode
    }

    It "kubectl" {
        "kubectl version" | Should -MatchCommandOutput "Client Version: version.Info"
    }

    It "helm" {
        "helm version" | Should -ReturnZeroExitCode
    }

    It "minikube" {
        "minikube version" | Should -ReturnZeroExitCode
    }

    It "kustomize" {
        "kustomize version" | Should -ReturnZeroExitCode
    }
}

Describe "Leiningen" {
    It "leiningen" {
        "lein --version" | Should -ReturnZeroExitCode
    }
}

Describe "Mercurial" {
    It "mercurial" {
        "hg --version" | Should -ReturnZeroExitCode
    }
}

Describe "Conda" {
    It "conda" {
        "conda --version" | Should -ReturnZeroExitCode
    }
}

Describe "Packer" {
    It "packer" {
        "packer --version" | Should -ReturnZeroExitCode
    }
}

Describe "Pulumi" {
    It "pulumi" {
        "pulumi version" | Should -ReturnZeroExitCode
    }
}

Describe "Phantomjs" {
    It "phantomjs" {
        "phantomjs --version" | Should -ReturnZeroExitCode
    }
}

Describe "GraalVM" -Skip:(-not (Test-IsUbuntu20)) {
    It "graalvm" {
        '$GRAALVM_11_ROOT/bin/java -version' | Should -ReturnZeroExitCode
    }

    It "native-image" {
        '$GRAALVM_11_ROOT/bin/native-image --version' | Should -ReturnZeroExitCode
    }
}

Describe "Containers" -Skip:(Test-IsUbuntu16) {
    $testCases = @("podman", "buildah", "skopeo") | ForEach-Object { @{ContainerCommand = $_} }

    It "<ContainerCommand>" -TestCases $testCases {
        param (
            [string] $ContainerCommand
        )

        "$ContainerCommand -v" | Should -ReturnZeroExitCode
    }   
}

Describe "Node.js" {
    $testCases = @("node", "grunt", "gulp", "webpack", "parcel", "yarn", "newman", "netlify", "vercel", "now") | ForEach-Object { @{NodeCommand = $_} }

    It "<NodeCommand>" -TestCases $testCases {
        param (
            [string] $NodeCommand
        )

        "$NodeCommand --version" | Should -ReturnZeroExitCode
    }
}

Describe "nvm" {
    It "nvm" {
        "source /etc/skel/.nvm/nvm.sh && nvm --version" | Should -ReturnZeroExitCode
    }
}

Describe "Python" {
    $testCases = @("python", "pip", "python3", "pip3") | ForEach-Object { @{PythonCommand = $_} }

    It "<PythonCommand>" -TestCases $testCases {
        param (
            [string] $PythonCommand
        )

        "$PythonCommand --version" | Should -ReturnZeroExitCode
    }   
}
