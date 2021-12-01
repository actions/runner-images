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
$MysqlVersion = [version](Get-ToolsetContent).mysql.version
if ($MysqlVersion.Build -lt 0) {
    $MysqlVersion = New-Object System.Version (
        $MysqlVersion.Major,
        $MysqlVersion.Minor,
        ([version]((Invoke-WebRequest -Uri https://dev.mysql.com/downloads/mysql/$($MysqlVersion.Major).$($MysqlVersion.Minor).html -UseBasicParsing).Content |
            Select-String -Pattern "$($MysqlVersion.Major).$($MysqlVersion.Minor)\.\d+").Matches.Value).Build
    )
}

$MysqlVersionUrl = "https://dev.mysql.com/get/Downloads/MySQL-$($MysqlVersion.Major).$($MysqlVersion.Minor)/mysql-$($MysqlVersion.ToString())-winx64.zip"

$MysqlArchPath = Start-DownloadWithRetry -Url $MysqlVersionUrl -Name "mysql.zip"

# Expand the zip
Extract-7Zip -Path $MysqlArchPath -DestinationPath "C:\"

# Rename mysql-version to mysql folder
$MysqlPath = "C:\mysql"
Invoke-SBWithRetry -Command {
    Rename-Item -Path "C:\mysql-$($MysqlVersion.ToString())-winx64" -NewName $MysqlPath -ErrorAction Stop
}

# Adding mysql in system environment path
Add-MachinePathItem "${MysqlPath}\bin"

Invoke-PesterTests -TestFile "Databases" -TestName "MySQL"
