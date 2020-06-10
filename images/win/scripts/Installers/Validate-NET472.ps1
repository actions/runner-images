################################################################################
##  File:  Validate-NET472.ps1
##  Desc:  Validate .NET 4.7.2
################################################################################

# For reference, visit https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
if (Get-ChildItem "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Get-ItemPropertyValue -Name Release | ForEach-Object { $_ -ge 461814 })
{
    $version = Get-ChildItem "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Get-ItemPropertyValue -Name Version
    Write-Host "Installed .Net version $version"
}
else 
{
    Write-Host ".Net 472 not found"
    exit 1
}

