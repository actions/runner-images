################################################################################
##  File:  Install-SignServerClient.ps1
##  Desc:  Install the Client we need to be able to sign our code
##         This includes hosts file records to reach the signing server(s)

################################################################################

"10.241.170.186 sign1.pki.thermofisher.com" | Add-Content -PassThru "$env:windir\System32\drivers\etc\hosts"
"10.239.133.217 ha-us.dso.thermofisher.net" | Add-Content -PassThru "$env:windir\System32\drivers\etc\hosts"
Invoke-WebRequest http://sign1.pki.thermofisher.com/signserver/clientcli-dist/signserver-clientcli.zip -OutFile c:\signserver-clientcli.zip
Expand-Archive -LiteralPath 'C:\signserver-clientcli.zip' -DestinationPath C:
Set-Item -Path Env:SIGNSERVER_HOME 'C:\signserver'
