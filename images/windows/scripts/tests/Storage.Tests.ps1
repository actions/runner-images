################################################################################
##  File:  Storage.Tests.ps1
##  Desc:  Validate the temporary volume used during image generation
################################################################################

Describe "Temporary storage" {
    It "TEMP_DIR is an existing directory on a healthy fixed volume" {
        $env:TEMP_DIR | Should -Match '^[A-Za-z]:\\.+'
        Test-Path -LiteralPath $env:TEMP_DIR -PathType Container | Should -BeTrue
        $volume = Get-Volume -DriveLetter $env:TEMP_DIR.Substring(0, 1)
        $volume.DriveType | Should -Be "Fixed"
        $volume.FileSystem | Should -Not -BeNullOrEmpty
        $volume.HealthStatus | Should -Be "Healthy"
    }
}
