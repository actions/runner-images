Describe "Kotlin" {
    $kotlinPackages =  @("kapt", "kotlin", "kotlinc", "kotlin-dce-js", "kotlinc-js", "kotlinc-jvm")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object { @{ toolName = $_ } })  { 
        "$toolName -version" | Should -ReturnZeroExitCode
    }
}