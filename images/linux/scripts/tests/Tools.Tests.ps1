Describe "azcopy" {
    It "azcopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }

    It "azcopy10 link exists" {
        "azcopy10 --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "Rust" {
    BeforeAll {
        $env:PATH = "/etc/skel/.cargo/bin:/etc/skel/.rustup/bin:$($env:PATH)"
        $env:RUSTUP_HOME = "/etc/skel/.rustup"
        $env:CARGO_HOME = "/etc/skel/.cargo"
    }

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

    It "docker compose v2" {
        "docker compose" | Should -ReturnZeroExitCode
    }

    It "docker-credential-ecr-login" {
        "docker-credential-ecr-login -v" | Should -ReturnZeroExitCode
    }

    Context "docker images" {
        $testCases = (Get-ToolsetContent).docker.images | ForEach-Object { @{ ImageName = $_ } }

        It "<ImageName>" -TestCases $testCases {
           sudo docker images "$ImageName" --format "{{.Repository}}" | Should -Not -BeNullOrEmpty
        }
    }
}

Describe "Docker-compose v1" {
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
        "clang-format-$ClangVersion --version" | Should -ReturnZeroExitCode
        "clang-tidy-$ClangVersion --version" | Should -ReturnZeroExitCode
        "run-clang-tidy-$ClangVersion --help" | Should -ReturnZeroExitCode
    }
}

Describe "Cmake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "erlang" -Skip:(Test-IsUbuntu22) {
    $testCases = @("erl -version", "erlc -v", "rebar3 -v") | ForEach-Object { @{ErlangCommand = $_} }

    It "erlang <ErlangCommand>" -TestCases $testCases {
        param (
            [string] $ErlangCommand
        )

        "$ErlangCommand" | Should -ReturnZeroExitCode
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

    It "msbuild" {
        "msbuild -version" | Should -ReturnZeroExitCode
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

Describe "SqlPackage" {
    It "sqlpackage" {
        "sqlpackage /version" | Should -ReturnZeroExitCode
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
    It "Selenium is installed" {
        $seleniumBinaryName = (Get-ToolsetContent).selenium.binary_name
        $seleniumPath = Join-Path "/usr/share/java" "$seleniumBinaryName.jar"
        $seleniumPath | Should -Exist
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

Describe "HHVM" -Skip:(Test-IsUbuntu22) {
    It "hhvm" {
        "hhvm --version" | Should -ReturnZeroExitCode
    }
}

Describe "Homebrew" {
    $brewToolset = (Get-ToolsetContent).brew
    $testCases = $brewToolset | ForEach-Object { @{brewName = $_.name; brewCommand = $_.command} }

    It "homebrew" {
        "/home/linuxbrew/.linuxbrew/bin/brew --version" | Should -ReturnZeroExitCode
    }

    It "zstd has /usr/local/bin symlink" {
        "/usr/local/bin/zstd" | Should -Exist
    }

    It "homebrew package <brewName>" -TestCases $testCases {
        $brewPrefix = /home/linuxbrew/.linuxbrew/bin/brew --prefix $brewName
        $brewPackage = Join-Path $brewPrefix "bin" $brewCommand

        "$brewPackage --version" | Should -ReturnZeroExitCode
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

Describe "Phantomjs" -Skip:(Test-IsUbuntu22) {
    It "phantomjs" {
        "phantomjs --version" | Should -ReturnZeroExitCode
    }
}

Describe "GraalVM" -Skip:(Test-IsUbuntu18) {
    It "graalvm" {
        '$GRAALVM_11_ROOT/bin/java -version' | Should -ReturnZeroExitCode
    }

    It "native-image" {
        '$GRAALVM_11_ROOT/bin/native-image --version' | Should -ReturnZeroExitCode
    }
}

Describe "Containers" {
    $testCases = @("podman", "buildah", "skopeo") | ForEach-Object { @{ContainerCommand = $_} }

    It "<ContainerCommand>" -TestCases $testCases {
        param (
            [string] $ContainerCommand
        )

        "$ContainerCommand -v" | Should -ReturnZeroExitCode
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

Describe "Ruby" {
    $testCases = @("ruby", "gem") | ForEach-Object { @{RubyCommand = $_} }

    It "<RubyCommand>" -TestCases $testCases {
        param (
            [string] $RubyCommand
        )

        "$RubyCommand --version" | Should -ReturnZeroExitCode
    }

    $gemTestCases = (Get-ToolsetContent).rubygems | ForEach-Object {
        @{gemName = $_.name}
    }

    if ($gemTestCases)
    {
        It "Gem <gemName> is installed" -TestCases $gemTestCases {
            "gem list -i '^$gemName$'" | Should -MatchCommandOutput "true"
        }
    }
}

Describe "yq" {
    It "yq" {
        "yq -V" | Should -ReturnZeroExitCode
    }
}

Describe "Kotlin" {
    It "kapt" {
        "kapt -version"| Should -ReturnZeroExitCode
    }

    It "kotlin" {
        "kotlin -version"| Should -ReturnZeroExitCode
    }

    It "kotlinc" {
        "kotlinc -version"| Should -ReturnZeroExitCode
    }

    It "kotlinc-js" {
        "kotlinc-js -version"| Should -ReturnZeroExitCode
    }

    It "kotlinc-jvm" {
        "kotlinc-jvm -version"| Should -ReturnZeroExitCode
    }

    It "kotlin-dce-js" {
        "kotlin-dce-js -version"| Should -ReturnZeroExitCode
    }
}
