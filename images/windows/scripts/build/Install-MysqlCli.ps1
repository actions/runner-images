################################################################################
##  File:  Install-MysqlCli.ps1
##  Desc:  Install Mysql CLI
################################################################################

# Installing visual c++ redistibutable package.
$InstallerName = "vcredist_x64.exe"
$InstallerURI = "https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/${InstallerName}"
$ArgumentList = ("/install", "/quiet", "/norestart")
$InstallerSignatureThumbrint = "3BDA323E552DB1FDE5F4FBEE75D6D5B2B187EEDC"

Install-Binary -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList -ExpectedSignature $InstallerSignatureThumbrint

# Downloading mysql
[version]$MysqlVersion = (Get-ToolsetContent).mysql.version
$MysqlVersionMajorMinor = $MysqlVersion.ToString(2)

if ($MysqlVersion.Build -lt 0) {
    $MysqlVersion = (Invoke-RestMethod -Uri "https://dev.mysql.com/downloads/mysql/${MysqlVersionMajorMinor}.html" -Headers @{'Accept'='text/html'} |
        Select-String -Pattern "${MysqlVersionMajorMinor}\.\d+").Matches.Value
}

$MysqlVersionFull = $MysqlVersion.ToString()
$MysqlVersionUrl = "https://cdn.mysql.com/Downloads/MySQL-${MysqlVersionMajorMinor}/mysql-${MysqlVersionFull}-winx64.msi"

Install-Binary -Url $MysqlVersionUrl -Name "mysql-${MysqlVersionFull}-winx64.msi" -ExpectedSignature (Get-ToolsetContent).mysql.signature

# Adding mysql in system environment path
$MysqlPath = $(Get-ChildItem -Path "C:\PROGRA~1\MySQL" -Directory)[0].FullName

Add-MachinePathItem "${MysqlPath}\bin"

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"
