Describe "Docker" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "docker" }
        @{ ToolName = "docker-compose" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }

    It "docker-wincred" {
        "docker-credential-wincred version" | Should -ReturnZeroExitCode
    }

    It "docker compose v2" {
        "docker compose version" | Should -ReturnZeroExitCode
    }

    It "docker service is up" {
        "docker images" | Should -ReturnZeroExitCode
    }

    It "docker symlink" {
        "C:\Windows\SysWOW64\docker.exe ps" | Should -ReturnZeroExitCode
    }
}

Describe "DockerImages" {
    Context "docker images" {
        $testCases = (Get-ToolsetContent).docker.images | ForEach-Object { @{ ImageName = $_ } }

        It "<ImageName>" -TestCases $testCases {
            docker images "$ImageName" --format "{{.Repository}}" | Should -Not -BeNullOrEmpty
        }
    }
}