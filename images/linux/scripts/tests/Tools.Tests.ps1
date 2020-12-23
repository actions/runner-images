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
        "kubectl version" | Should -ReturnZeroExitCode
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