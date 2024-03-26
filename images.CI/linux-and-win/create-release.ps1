param(
    [Parameter (Mandatory)] [UInt32] $BuildId,
    [Parameter (Mandatory)] [string] $Organization,
    [Parameter (Mandatory)] [string] $Project,
    [Parameter (Mandatory)] [string] $ImageType,
    [Parameter (Mandatory)] [string] $ManagedImageName,
    [Parameter (Mandatory)] [string] $DefinitionId,
    [Parameter (Mandatory)] [string] $AccessToken
)

$Body = @{
    definitionId = $DefinitionId
    variables = @{
      ImageBuildId = @{
        value = $BuildId
      }
      ImageType = @{
        value = $ImageType
      }
      ManagedImageName = @{
        value = $ManagedImageName
      }
    }
    isDraft = "false"
} | ConvertTo-Json -Depth 3

$URL = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.1"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("'':${AccessToken}"))
$headers = @{
    Authorization = "Basic ${base64AuthInfo}"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
$NewRelease = Invoke-RestMethod $URL -Body $Body -Method "POST" -Headers $headers -ContentType "application/json"

Write-Host "Created release: $($NewRelease._links.web.href)"
