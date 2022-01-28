Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Common.psm1") -DisableNameChecking

Describe "Azure Cosmos DB Emulator" {
    $cosmosDbEmulatorRegKey = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Get-ItemProperty | Where-Object { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }
    $installDir = $cosmosDbEmulatorRegKey.InstallLocation

    It "Azure Cosmos DB Emulator install location registry key exists" -TestCases @{installDir = $installDir} {
        $installDir | Should -Not -BeNullOrEmpty
    }

    It "Azure Cosmos DB Emulator exe file exists" -TestCases @{installDir = $installDir} {
        $exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
        $exeFilePath | Should -Exist
    }
}

Describe "Bazel" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bazel" }
        @{ ToolName = "bazelisk" }
    ) {
        "$ToolName --version"| Should -ReturnZeroExitCode
    }
}

Describe "CodeQLBundle" {
    It "CodeQLBundle" {
        $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "codeql" | Join-Path -ChildPath "*"
        $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
        $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql.exe"
        "$CodeQLPath version" | Should -ReturnZeroExitCode
    }
}

Describe "R" {
    It "Rscript" {
        "Rscript --version" | Should -ReturnZeroExitCode
    }
}

Describe "DACFx" {
    It "DACFx" {
        (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Contains "Microsoft SQL Server Data-Tier Application Framework (x64)" | Should -BeTrue
        $sqlPackagePath = 'C:\Program Files\Microsoft SQL Server\160\DAC\bin\SqlPackage.exe'
        "${sqlPackagePath}" | Should -Exist
    }

    It "SqlLocalDB" -Skip:(Test-IsWin22) {
        $sqlLocalDBPath = 'C:\Program Files\Microsoft SQL Server\130\Tools\Binn\SqlLocalDB.exe'
        "${sqlLocalDBPath}" | Should -Exist
    }
}

Describe "DotnetTLS" -Skip:(Test-IsWin22) {
    It "Tls 1.2 is enabled" {
        [Net.ServicePointManager]::SecurityProtocol -band "Tls12" | Should -Be Tls12
    }
}

Describe "Mercurial" {
    It "Mercurial" {
        "hg --version" | Should -ReturnZeroExitCode
    }
}

Describe "KubernetesTools" {
    It "Kind" {
        "kind version" | Should -ReturnZeroExitCode
    }

    It "kubectl" {
        "kubectl version --client=true --short=true" | Should -ReturnZeroExitCode
    }

    It "Helm" {
        "helm version --short" | Should -ReturnZeroExitCode
    }

    It "minikube" {
        "minikube version --short" | Should -ReturnZeroExitCode
    }
}

Describe "Mingw64" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "gcc" }
        @{ ToolName = "g++" }
        @{ ToolName = "make" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}

Describe "GoogleCloudSDK" -Skip:(Test-IsWin22) {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bq" }
        @{ ToolName = "gcloud" }
        @{ ToolName = "gsutil" }
    ) {
        "$ToolName version" | Should -ReturnZeroExitCode
    }
}

Describe "NET48" {
    It "NET48" {
        $netPath = (Get-DotnetFrameworkTools).Path.Split("<")[0]
        ${netPath} + "4.8 Tools" | Should -Exist
    }
}

Describe "NSIS" {
    It "NSIS" {
       "makensis /VERSION" | Should -ReturnZeroExitCode
    }
}

Describe "PowerShell Core" {
    It "pwsh" {
        "pwsh --version" | Should -ReturnZeroExitCode
    }

    It "Execute 2+2 command" {
        pwsh -Command "2+2" | Should -BeExactly 4
    }
}

Describe "Sbt" {
    It "sbt" {
        "sbt --version" | Should -ReturnZeroExitCode
    }
}

Describe "ServiceFabricSDK" {
    It "PowerShell Module" {
        Get-Module -Name ServiceFabric -ListAvailable | Should -Not -BeNullOrEmpty
    }

    It "ServiceFabricSDK version" {
        Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Service Fabric\' -Name FabricVersion | Should -Not -BeNullOrEmpty
    }
}

Describe "Stack" {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "Vcpkg" {
    It "vcpkg" {
      "vcpkg version" | Should -ReturnZeroExitCode
    }

    It "env variable VCPKG_INSTALLATION_ROOT is set" {
      $env:VCPKG_INSTALLATION_ROOT | Should -Not -BeNullOrEmpty
    }

    It "VCPKG_INSTALLATION_ROOT directory" {
        $env:VCPKG_INSTALLATION_ROOT | Should -Exist
    }
}

Describe "VCRedist" -Skip:(Test-IsWin22) {
    It "vcredist_140" -Skip:(Test-IsWin19) {
        "C:\Windows\System32\vcruntime140.dll" | Should -Exist
    }

    It "vcredist_2010_x64" -Skip:(Test-IsWin16) {
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1D8E6291-B0D5-35EC-8441-6616F567A0F7}" | Should -Exist
        "C:\Windows\System32\msvcr100.dll" | Should -Exist
    }

    It "vcredist_2010_x64" -Skip:(Test-IsWin16) {
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1D8E6291-B0D5-35EC-8441-6616F567A0F7}" | Should -Exist
        "C:\Windows\System32\msvcr100.dll" | Should -Exist
    }
}

Describe "WebPlatformInstaller" {
    It "WebPlatformInstaller" {
        "WebPICMD" | Should -ReturnZeroExitCode
    }
}

Describe "Zstd" {
    It "zstd" {
        "zstd -V" | Should -ReturnZeroExitCode
    }
}

Describe "Pipx" {
    It "Pipx" {
        "pipx --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kotlin" {
    $kotlinPackages =  @("kapt", "kotlin", "kotlinc", "kotlin-dce-js", "kotlinc-js", "kotlinc-jvm")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object { @{ toolName = $_ } })  {
        "$toolName -version" | Should -ReturnZeroExitCode
    }
}

Describe "SQL OLEDB Driver" -Skip:(Test-IsWin16) {
    It "SQL OLEDB Driver" {
        "HKLM:\SOFTWARE\Microsoft\MSOLEDBSQL" | Should -Exist
    }
}