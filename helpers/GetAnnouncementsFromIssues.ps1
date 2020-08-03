function Get-IssueLabels {
    param (
        [PSCustomObject] $Issue
    )

    $labels = @()
    foreach($label in $Issue.labels) {
        $labels += $label.Name
    }

    return $labels
}

function Set-ADOVariable {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name,
        [Parameter(Mandatory=$true)]
        [string] $Value
    )

    Write-Host "##vso[task.setvariable variable=${Name};]${Value}"
}

$url = "https://api.github.com/repos/actions/virtual-environments/issues"
$issues = Invoke-RestMethod $url

foreach( $issue in $issues) {
    $windowsAnnouncements = @()
    $ubuntuAnnouncements = @()
    $macosAnnouncements = @()
    $labels = Get-IssueLabels -Issue $issue
    if ($labels -NotContains "Announcement") {
        continue
    }
    if ($labels -Contains "OS: Windows") {
        $windowsAnnouncements += "$($issue.title)===$($issue.html_url)"
    }
    if ($labels -Contains "OS: Ubuntu") {
        $ubuntuAnnouncements += "$($issue.title)===$($issue.html_url)"
    }
    if ($labels -Contains "OS: macOS") {
        $macosAnnouncements += "$($issue.title)===$($issue.html_url)"
    }
}

if ($windowsAnnouncements) {
    Set-ADOVariable -Name "WINDOWS_ANNOUNCEMENTS" -Value $windowsAnnouncements.join(";;")
}

if ($ubuntuAnnouncements) {
    Set-ADOVariable -Name "UBUNTU_ANNOUNCEMENTS" -Value $ubuntuAnnouncements.join(";;")
}

if ($macosAnnouncements) {
    Set-ADOVariable -Name "MACOS_ANNOUNCEMENTS" -Value macosAnnouncements.join(";;")
}