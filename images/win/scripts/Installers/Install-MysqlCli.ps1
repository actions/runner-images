################################################################################
##  File:  Install-MysqlCli.ps1
##  Desc:  Install Mysql CLI
################################################################################

# Installing visual c++ redistibutable package.
$InstallerName = "vcredist_x64.exe"
$InstallerURI = "https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/${InstallerName}"
$ArgumentList = ("/install", "/quiet", "/norestart")

Install-Binary -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList

## Downloading mysql
if (Test-IsWin22) {
    $MysqlVersionName = "mysql-8.0.26-winx64"
    $MysqlVersionUrl = "https://dev.mysql.com/get/Downloads/MySQL-8/${MysqlVersionName}.zip"
} else {
    $MysqlVersionName = "mysql-5.7.35-winx64"
    $MysqlVersionUrl = "https://dev.mysql.com/get/Downloads/MySQL-5.7/${MysqlVersionName}.zip"
}

$MysqlArchPath = Start-DownloadWithRetry -Url $MysqlVersionUrl -Name "mysql.zip"

# Expand the zip
Extract-7Zip -Path $MysqlArchPath -DestinationPath "C:\"

# Rename mysql-version to mysql folder
$MysqlPath = "C:\mysql"
Rename-Item -Path "C:\${MysqlVersionName}" -NewName $MysqlPath

# Adding mysql in system environment path
Add-MachinePathItem "${MysqlPath}\bin"

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"
