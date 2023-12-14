################################################################################
##  File:  Install-MysqlCli.ps1
##  Desc:  Install Mysql CLI
################################################################################

# Installing visual c++ redistributable package.
Install-Binary `
    -Url 'https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x64.exe' `
    -InstallArgs @("/install", "/quiet", "/norestart") `
    -ExpectedSignature '3BDA323E552DB1FDE5F4FBEE75D6D5B2B187EEDC'

# Downloading mysql
[version] $mysqlVersion = (Get-ToolsetContent).mysql.version
$mysqlVersionMajorMinor = $mysqlVersion.ToString(2)

if ($mysqlVersion.Build -lt 0) {
    $downloadsPageUrl = "https://dev.mysql.com/downloads/mysql/${mysqlVersionMajorMinor}.html"
    $mysqlVersion = Invoke-RestMethod -Uri $downloadsPageUrl -Headers @{ 'User-Agent' = 'curl/8.4.0' } `
    | Select-String -Pattern "${mysqlVersionMajorMinor}\.\d+" `
    | ForEach-Object { $_.Matches.Value }
}

$mysqlVersionFull = $mysqlVersion.ToString()
$mysqlVersionUrl = "https://cdn.mysql.com/Downloads/MySQL-${mysqlVersionMajorMinor}/mysql-${mysqlVersionFull}-winx64.msi"

Install-Binary `
    -Url $mysqlVersionUrl `
    -ExpectedSignature (Get-ToolsetContent).mysql.signature

# Adding mysql in system environment path
$mysqlPath = $(Get-ChildItem -Path "C:\PROGRA~1\MySQL" -Directory)[0].FullName

Add-MachinePathItem "${mysqlPath}\bin"

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"
