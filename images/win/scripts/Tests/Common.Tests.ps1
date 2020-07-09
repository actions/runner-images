Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kind" {
    It "Kind" {
        "kind version" | Should -ReturnZeroExitCode
    }

    It "Debug path" {
        $TestFile = "Common"
        $testPath1 = "C:\image\Tests\${TestFile}.Tests.ps1"
        $testPath2 = Join-Path $env:SystemDrive "image\Tests\${TestFile}.Tests.ps1"
        $testPath1 | Should -Be $testPath2
    }
}

Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}
