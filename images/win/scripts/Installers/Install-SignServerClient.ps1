################################################################################
##  File:  Install-SignServerClient.ps1
##  Desc:  Install the Client we need to be able to sign our code
##         This includes hosts file records to reach the signing server(s)

################################################################################

Invoke-WebRequest https://downloads.sourceforge.net/project/signserver/signserver/5.2/signserver-ce-5.2.0.Beta1-bin.zip -OutFile c:\google.html

$FirefoxDirectoryPath = Join-Path $env:ProgramFiles "Mozilla Firefox"
Add-MachinePathItem -PathItem $GeckoDriverPath
