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
    It "AWS" {
        "aws --version" | Should -ReturnZeroExitCode
    }
}

Describe "AWSSAM" {
    It "AWSSAM" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}

Describe "AWSSessionManagerPlugin is installed" {
    It "AWSSessionManagerPlugin" {
        session-manager-plugin | Out-String | Should -Match "plugin was installed successfully"
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