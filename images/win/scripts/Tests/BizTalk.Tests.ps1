################################################################################
##  File:  BizTalk.Tests.ps1
##  Desc:  Test BizTalk project build component installed.
################################################################################

Describe "BizTalk Build Component Setup" -Skip:(Test-IsWin16) {
    It "BizTalk Registry Check" {
        Test-Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\BizTalk Server\3.0" | Should -BeTrue
    }

    It "BizTalk Folder Check" {
        "${env:ProgramFiles(x86)}\Microsoft BizTalk Server" | Should -Exist
    }

    It "BizTalk Build Targets files Check" {
        "${env:ProgramFiles(x86)}\MSBuild\Microsoft\BizTalk\BizTalkC.targets" | Should -Exist
        "${env:ProgramFiles(x86)}\MSBuild\Microsoft\BizTalk\BizTalkCommon.targets" | Should -Exist
    }
}