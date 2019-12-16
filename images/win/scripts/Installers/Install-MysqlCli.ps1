################################################################################
##  File:  Install-MysqlCli.ps1
##  Desc:  Install Mysql CLI
################################################################################


## Downloading mysql jar
$uri = 'https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.21-winx64.zip'
$mysqlPath = 'C:\mysql-5.7.21-winx64\bin'

# Installing visual c++ redistibutable package.
$InstallerURI = 'https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x64.exe'
$InstallerName = 'vcredist_x64.exe'
$ArgumentList = ('/install', '/quiet', '/norestart' )

$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
if ($exitCode -eq 0 -or $exitCode -eq 3010)
{
    # MySQL disabled TLS 1.0 support on or about Jul-14-2018.  Need to make sure TLS 1.2 is enabled.
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

    # Get the latest mysql command line tools .
    Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile mysql.zip

    # Expand the zip
    Expand-Archive -Path mysql.zip -DestinationPath "C:\" -Force

    # Deleting zip folder
    Remove-Item -Recurse -Force mysql.zip

    # Adding mysql in system environment path
    Add-MachinePathItem $mysqlPath

    return 0;
}
else
{
    return $exitCode;
}
