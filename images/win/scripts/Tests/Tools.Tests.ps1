Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "AliyunCli" {
    It "AliyunCli" {
        "aliyun version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }

    It "Session Manager Plugin for the AWS CLI" {
        session-manager-plugin | Out-String | Should -Match "plugin was installed successfully"
    }

    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "CMake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kind" {
    It "Kind" {
        "kind version" | Should -ReturnZeroExitCode
    }
}