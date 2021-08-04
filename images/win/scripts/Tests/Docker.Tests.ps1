Describe "Docker" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "docker" }
        @{ ToolName = "docker-compose" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }

    It "docker service is up" {
        "docker images" | Should -ReturnZeroExitCode
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