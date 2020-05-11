################################################################################
##  File:  Validate-SQLExpress.ps1
##  Desc:  Validate Microsoft SQL Express installation
################################################################################

#Parameters for database access
$sqlUser = "sa"
$sqlPassword = "P@ssword!!"
$sqlInstance = "SQL2019"

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
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString
        $sqlConnection.Open()
        Write-Host -Object "Connection to SQL Express was successful."
        return $sqlConnection.ServerVersion

    } catch {
        Write-Host -Object "Connection to SQL Express cannot be established."
        exit 1

    } finally {
        ## Close the connection when we're done
        $sqlConnection.Close()
    }
}
$instanceName = "$env:computername\$sqlInstance"
$version = Test-SqlConnection -ServerName $instanceName -IntegratedSecurity "false" -UserName $sqlUser -Password $sqlPassword

# Adding description of the software to Markdown
$SoftwareName = "Microsoft SQL Express"
$Description = @"
_Version:_ $version<br/>
_InstanceName:_ $sqlInstance<br/>
_Username:_ $sqlUser<br/>
_Password:_ $sqlPassword<br/>
_Default Path:_ C:\Program Files (x86)\Microsoft SQL Server
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
