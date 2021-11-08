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
$MysqlShortVersion = (Get-ToolsetContent).Mysql.short_version
$MysqlFullVersion = (Get-ToolsetContent).Mysql.full_version
$MysqlVersionUrl = "https://dev.mysql.com/get/Downloads/MySQL-${MysqlShortVersion}/mysql-${MysqlFullVersion}-winx64.zip"

$MysqlArchPath = Start-DownloadWithRetry -Url $MysqlVersionUrl -Name "mysql.zip"

# Expand the zip
Extract-7Zip -Path $MysqlArchPath -DestinationPath "C:\"

# Rename mysql-version to mysql folder
$MysqlPath = "C:\mysql"
Rename-Item -Path "C:\mysql-${MysqlFullVersion}-winx64" -NewName $MysqlPath

# Adding mysql in system environment path
Add-MachinePathItem "${MysqlPath}\bin"

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"
