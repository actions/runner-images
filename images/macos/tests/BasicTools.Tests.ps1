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

Describe "Subversion" -Skip:($os.IsVentura) {
    It "Subversion" {
        "svn --version" | Should -ReturnZeroExitCode
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

Describe "Helm" -Skip:($os.IsMonterey -or $os.IsVentura) {
    It "Helm" {
        "helm version --short" | Should -ReturnZeroExitCode
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

Describe "Aliyun CLI" -Skip:($os.IsMonterey -or $os.IsVentura) {
    It "Aliyun CLI" {
        "aliyun --version" | Should -ReturnZeroExitCode
    }
}

Describe "Julia" {
    It "Julia" {
        "julia --version" | Should -ReturnZeroExitCode
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

Describe "vagrant" -Skip:($os.IsBigSur) {
    It "vagrant" {
        "vagrant --version" | Should -ReturnZeroExitCode
    }
}

Describe "virtualbox" -Skip:($os.IsBigSur -or $os.IsVentura) {
    It "virtualbox" {
        "vboxmanage -v" | Should -ReturnZeroExitCode
    }
}

Describe "R" {
    It "R" {
        "R --version" | Should -ReturnZeroExitCode
    }
}

Describe "Homebrew" {
    It "Homebrew" {
        "brew --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kotlin" {
    $kotlinPackages =  @("kapt", "kotlin", "kotlinc", "kotlinc-jvm", "kotlin-dce-js")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object {  @{ toolName = $_ } })  { 
        "$toolName -version" | Should -ReturnZeroExitCode
    }
}

Describe "sbt" -Skip:($os.IsVentura) {
    It "sbt" {
        "sbt -version" | Should -ReturnZeroExitCode
    }
}

Describe "yq" {
    It "yq" {
        "yq --version" | Should -ReturnZeroExitCode
    }
}

Describe "imagemagick" -Skip:($os.IsVentura) {
    It "imagemagick" {
        "magick -version" | Should -ReturnZeroExitCode
    }
}