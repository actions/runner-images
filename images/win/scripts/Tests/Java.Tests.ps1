Describe "Java" {
    $toolsetJava = (Get-ToolsetContent).java
    $defaultVendor = $toolsetJava.default_vendor
    $javaVendors = $toolsetJava.vendors
    $defaultVersion = $toolsetJava.default

    [array]$jdkVersions = ($javaVendors | Where-Object {$_.name -eq $defaultVendor}).versions | ForEach-Object { @{Version = $_} }
    [array]$adoptJdkVersions = ($javaVendors | Where-Object {$_.name -eq "Adopt"}).versions | ForEach-Object { @{Version = $_} }

    It "Java <DefaultJavaVersion> is default" -TestCases @(@{ DefaultJavaVersion = $defaultVersion }) {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_X64"

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
        @{ ToolName = "gradle" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    It "Java <Version>" -TestCases $jdkVersions {
        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${Version}_X64"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin\java"

        $result = Get-CommandResult "`"$javaPath`" -version"
        $result.ExitCode | Should -Be 0

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
        $outputPattern = "openjdk version `"${Version}"
        $result.Output[0] | Should -Match $outputPattern
    }

    It "Java Adopt Jdk <Version>" -TestCases $adoptJdkVersions {
        $adoptPath = Join-Path (Get-ChildItem ${env:AGENT_TOOLSDIRECTORY}\Java_Adopt_jdk\${Version}*) "x64\bin\java"

        $result = Get-CommandResult "`"$adoptPath`" -version"
        $result.ExitCode | Should -Be 0

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
        $outputPattern = "openjdk version `"${Version}"
        $result.Output[0] | Should -Match $outputPattern
    }
}
