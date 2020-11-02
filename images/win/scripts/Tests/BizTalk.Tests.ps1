################################################################################
##  File:  BizTalk.Tests.ps1
##  Desc:  Test BizTalk project build component installed.
################################################################################

Describe "BizTalk Build" {
    BeforeAll {
        $testSlnUri = "https://aka.ms/DevOpsAgentBuildSmokeTest.zip"

        # Download
        try {
            Write-Host "BizTalk Project Build Component test solution download..."
            $testSlnZipFile = Start-DownloadWithRetry -Url $testSlnUri -Name "DevOpsAgentBuildSmokeTest.zip"
        }
        catch {
            Write-Error "[!] Failed to download $testSlnUri"
            exit 1
        }

        # Unzip
        $testSlnPath = "C:\BizTalkBuildComponent\TestSln"
        if (-not (Test-Path -Path $testSlnPath)) {
            $null = New-Item -Path $testSlnPath -ItemType Directory -Force
        }

        Write-Host "Unzip $testSlnZipFile to $testSlnPath..."
        Extract-7Zip -Path $testSlnZipFile -DestinationPath $testSlnPath
        Remove-Item $testSlnZipFile
        $testSlnPath = "$testSlnPath\btsplayer\BtsPlayer.sln"

        $vsInstallRoot = Get-VisualStudioPath
        $msbuildexePath = "${vsInstallRoot}\MSBuild\Current\Bin\MSBuild.exe"
    }
        It "Msbuild BizTalk Solution" {
             "`"$msbuildexePath`" $testSlnPath" | Should -ReturnZeroExitCode
    }
}