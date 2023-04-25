
Describe "Azure CLI" {
    It "Azure CLI" {
        "az --version" | Should -ReturnZeroExitCode
    }
}

Describe "Azure DevOps CLI" {
    It "az devops" {
        "az devops -h" | Should -ReturnZeroExitCode
    }
}

Describe "Aliyun CLI" {
    It "Aliyun CLI" {
        "aliyun version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }

    It "Session Manager Plugin for the AWS CLI" {
        session-manager-plugin 2>&1 | Out-String | Should -Match "plugin was installed successfully"
    }

    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}

Describe "GitHub CLI" {
    It "gh cli" {
        "gh --version" | Should -ReturnZeroExitCode
    }

    It "hub is installed" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}

Describe "Google Cloud SDK" {
    It "Google Cloud SDK" {
        "gcloud --version" | Should -ReturnZeroExitCode
    }
}

Describe "OC CLI" {
    It "OC CLI" {
        "oc version" | Should -ReturnZeroExitCode
    }
}

Describe "Oras CLI" {
    It "Oras CLI" {
        "oras version" | Should -ReturnZeroExitCode
    }
}