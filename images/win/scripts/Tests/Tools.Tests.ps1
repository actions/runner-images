Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
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

Describe "DotnetTLS" {
    It "Tls 1.2 is enabled" {
        $protocols = [Net.ServicePointManager]::SecurityProtocol
        $protocolArr = $protocols -split ', '
        $protocolArr.Contains('Tls12') | Should -BeTrue
    }
}