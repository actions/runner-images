param(
    [String] [Parameter (Mandatory=$true)] $CustomRepoUrl,
    [String] [Parameter (Mandatory=$true)] $CustomRepoBranch
)

Write-Host "Clean up default repository"
Remove-Item -path './*' -Recurse -Force

Write-Host "Download ${CustomRepoBranch} branch from ${CustomRepoUrl}"
$env:GIT_REDIRECT_STDERR = '2>&1'
git clone $CustomRepoUrl . -b $CustomRepoBranch --single-branch --depth 1

Write-Host "Latest commit:"
git log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1