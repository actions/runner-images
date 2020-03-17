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
        Write-Host -Object "Connection to SQL Express was successful."
    } catch {
        Write-Host -Object "Connection to SQL Express cannot be established."
        exit 1
    } finally {
        ## Close the connection when we're done
        $sqlConnection.Close()
    }
}
$instanceName = "$env:computername\SQL2019"
Test-SqlConnection -ServerName $instanceName -IntegratedSecurity "false" -UserName "sa" -Password "P@ssword!!"