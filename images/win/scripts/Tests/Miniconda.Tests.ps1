Describe "Miniconda" {
    It "Miniconda Environment variables is set. " {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
    }
    
    It "Miniconda $env:CONDA\<PathTest> " -TestCases @(
        @{ PathTest = "python.exe" }
        @{ PathTest = "Scripts\conda.exe" }
    ) {
        Join-Path ${env:CONDA} $PathTest | Should -Exist
    }
}