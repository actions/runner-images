################################################################################
##  File:  Validate-SQLExpress.ps1
##  Desc:  Validate Microsoft SQL Express installation
################################################################################
function Test-SqlConnection {
    param(
        [Parameter(Mandatory)]
        [string]$ServerName,

        [Parameter(Mandatory)]
        [string]$IntegratedSecurity,

        [Parameter(Mandatory)]
        [string]$UserName,

        [Parameter(Mandatory)]
        [string]$Password
    )

    $ErrorActionPreference = 'Stop'

    try {
        $connectionString = 'Server={0};Integrated Security={1};User ID={2};Password={3}' -f $ServerName,$IntegratedSecurity,$UserName,$Password
        Write-Host -Object "Trying to connect to SQL Express instance: $ServerName"
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString
        $sqlConnection.Open()
        Write-Host -Object "Connection to database: {0} in in was successful. Version of SQL Express is: {1}" -f $sqlConnection.Database,$sqlConnection.ServerVersion
        return $sqlConnection.ServerVersion
    } catch {
        Write-Host -Object "Connection to SQL Express cannot be established."
        exit 1
    } finally {
        ## Close the connection when we're done
        $sqlConnection.Close()
    }
}
$instanceName = "$env:computername\SQL2019"
$version = Test-SqlConnection -ServerName $instanceName -IntegratedSecurity "false" -UserName "sa" -Password "P@ssword!!"

# Adding description of the software to Markdown
$SoftwareName = "Git"

$Description = @"
_Version:_ $version<br/>
_InstanceName:_ SQL2019<br/>
_Username:_ sa<br/>
_Password:_ P@ssword!!<br/>
_Default Path:_ C:\Program Files (x86)\Microsoft SQL Server
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
