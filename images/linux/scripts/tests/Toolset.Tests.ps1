Describe "Toolset" {
    $tools = (Get-ToolsetContent).toolcache

    $toolsExecutables = @{
        Python = @{
            tools = @("python", "bin/pip")
            command = "--version"
        }
        node = @{
            tools = @("bin/node", "bin/npm")
            command = "--version"
        }
        PyPy = @{
            tools = @("bin/python", "bin/pip")
            command = "--version"
        }
        go = @{
            tools = @("bin/go")
            command = "version"
        }
        Ruby = @{
            tools = @("bin/ruby")
            command = "--version"
        }
        CodeQL = @{
            tools = @("codeql/codeql")
            command = "version"
        }
    }

    foreach($tool in $tools) {
        $toolName = $tool.Name
        Context "$toolName" {
            $toolExecs = $toolsExecutables[$toolName]

            foreach ($version in $tool.versions) {
                # Add wildcard if missing
                if ($version.Split(".").Length -lt 3) {
                    $version += ".*"
                }

                $expectedVersionPath = Join-Path $env:AGENT_TOOLSDIRECTORY $toolName $version

                It "$version version folder exists" -TestCases @{ ExpectedVersionPath = $expectedVersionPath} {
                    $ExpectedVersionPath | Should -Exist
                }

                $toolExecs = $toolsExecutables[$toolName]
                $foundVersion = Get-Item $expectedVersionPath `
                    | Sort-Object -Property {[SemVer]$_.name} -Descending `
                    | Select-Object -First 1
                $foundVersionPath = Join-Path $foundVersion $tool.arch

                if($toolExecs) {
                    foreach ($executable in $toolExecs["tools"]) {
                        $executablePath = Join-Path $foundVersionPath $executable   
    
                        It "Validate $executable" -TestCases @{ExecutablePath = $executablePath} {
                            $ExecutablePath | Should -Exist
                        }
                    }
                }

                # Validate that there are two versions of CodeQL included. 
                if ($toolName -eq "CodeQL") {
                    $foundPriorVersion = Get-Item $expectedVersionPath `
                        | Sort-Object -Property {[SemVer]$_.name} -Descending `
                        | Select-Object -Last 1
                    $foundPriorVersionPath = Join-Path $foundPriorVersion $tool.arch

                    $priorExecutablePath = Join-Path $foundPriorVersionPath "codeql/codeql"   
                    It "Validate prior version of codeql/codeql" -TestCases @{PriorExecutablePath = $priorExecutablePath} {
                        $PriorExecutablePath | Should -Exist
                    }
                }
            }
        }
    }
}