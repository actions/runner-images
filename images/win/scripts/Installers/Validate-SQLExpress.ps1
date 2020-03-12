$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = "Server=$env:computername\SQL2019;Integrated Security=false;User ID=sa; Password=P@ssword!!"
$sqlConn.Open()
$str1=""
$sqlConn.State
IF (Compare-Object $sqlConn.State $str1)
{
Write-Host "Failed attempt"
exit 1
}
ELSE
{
Write-Host "Success"
exit 0
}