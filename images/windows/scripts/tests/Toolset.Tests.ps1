$toolsExecutables = @{
    Python = @(
        @{ Binary = "python.exe"; Arguments = "--version" },
        @{ Binary = "Scripts\pip.exe"; Arguments = "--version" }
    )
    Node = @(
        @{ Binary = "node.exe"; Arguments = "--version" },
        @{ Binary = "npm"; Arguments = "--version" }
    )
    Go = @(
        @{ Binary = "bin\go.exe"; Arguments = "version" }
    )
    Ruby = @(
        @{ Binary = "bin\ruby.exe"; Arguments = "--version" }
    )
}

if (Test-IsX64) {
    $toolsExecutables.Add("PyPy", @(
        @{ Binary = "python.exe"; Arguments = "--version" },
        @{ Binary = "Scripts\pip.exe"; Arguments = "--version" }
    ))
}

function Get-ToolExecutables {
    Param ([String] $Name)
    if ($toolsExecutables.ContainsKey($Name)) { $toolsExecutables[$Name] } else { @() }
}

function Test-Binaries {
    Param (
        [String] $Name,
        [String] $Version,
        [String] $Arch,
        [Array] $ToolExecs
    )
    $testCases = $ToolExecs | ForEach-Object {
        @{ Name = $Name; Version = $Version; Arch = $Arch; Binary = $_.Binary; Arguments = $_.Arguments }
    }
    It "<Binary> <Arguments>" -TestCases $testCases {
        $binaryFullPath = Join-Path (Get-TCToolVersionPath -Name $Name -Version $Version -Arch $Arch) $Binary
        "$binaryFullPath $Arguments" | Should -ReturnZeroExitCode
    }
}

function Test-DefaultVersion {
    Param (
        [String] $Name,
        [String] $ExpectedVersion,
        [Array] $ToolExecs
    )
    $binaryName = [IO.Path]::GetFileNameWithoutExtension($ToolExecs[0].Binary)
    $testCase = @{ Binary = $binaryName; Arguments = $ToolExecs[0].Arguments; ExpectedVersion = $ExpectedVersion }
    It "<ExpectedVersion> is default version" -TestCases $testCase {
        $outputLines = (& $env:comspec /c "$Binary $Arguments 2>&1") -as [string[]]
        $LASTEXITCODE | Should -Be 0
        $outputLines | Should -Match $ExpectedVersion
    }

    It "default version is located in tool-cache" -TestCases $testCase {
        $binaryFullPath = (Get-Command $Binary).Path
        $toolcacheDirectory = Get-TCToolPath -ToolName $Name
        $binaryFullPath | Should -Match ([Regex]::Escape($toolcacheDirectory))
    }
}

$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache
foreach ($tool in $tools) {
    Describe "$($tool.name) [$($tool.arch)]" {
        $toolExecs = Get-ToolExecutables -Name $tool.name

        foreach ($version in $tool.versions) {
            Context "$version" {
                $toolInfo = @{ Name = $tool.name; Version = $version; Arch = $tool.arch }
                It "tool-cache directory exists" -TestCases $toolInfo {
                    $toolFullPath = Get-TCToolVersionPath -Name $Name -Version $Version -Arch $Arch
                    $toolFullPath | Should -Exist
                }

                if ($toolExecs) {
                    Test-Binaries -Name $tool.name -Version $version -Arch $tool.arch -ToolExecs $toolExecs
                }

                if ($tool.name -eq "Ruby") {
                    It "Ruby version matches the requested version" -TestCases $toolInfo {
                        $rubyPath = Join-Path (Get-TCToolVersionPath -Name $Name -Version $Version -Arch $Arch) "bin\ruby.exe"
                        $rubyVersion = & $rubyPath -e "print RUBY_VERSION"
                        $LASTEXITCODE | Should -Be 0
                        $rubyVersion | Should -BeLike "$Version.*"
                    }

                    It "Ruby cache has a completion marker" -TestCases $toolInfo {
                        $rubyCachePath = Get-TCToolVersionPath -Name $Name -Version $Version -Arch $Arch
                        "$rubyCachePath.complete" | Should -Exist
                    }

                    if (Test-IsArm64) {
                        It "Ruby uses the ARM64 cache layout and native binaries" -TestCases $toolInfo {
                            $Arch | Should -Be "arm64"
                            $rubyPath = Join-Path (Get-TCToolVersionPath -Name $Name -Version $Version -Arch "arm64") "bin\ruby.exe"
                            $hostCpu = & $rubyPath -rrbconfig -e "print RbConfig::CONFIG['host_cpu']"
                            $LASTEXITCODE | Should -Be 0
                            $hostCpu | Should -Match "^(aarch64|arm64)$"
                        }
                    }
                }
            }
        }

        if ($tool.default -and $toolExecs) {
            Context "Default" {
                Test-DefaultVersion -Name $tool.name -ExpectedVersion $tool.default -ToolExecs $toolExecs
            }
        }
    }
}
