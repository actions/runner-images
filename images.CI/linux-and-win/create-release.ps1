param(
    [Parameter(Mandatory)] [UInt32] $BuildId,
    [Parameter(Mandatory)] [string] $Organization,
    [Parameter(Mandatory)] [string] $Project,
    [Parameter(Mandatory)] [string] $ImageType,
    [Parameter(Mandatory)] [string] $ManagedImageName,
    [Parameter(Mandatory)] [string] $DefinitionId,
    [Parameter(Mandatory)] [string] $AccessToken
)
# Debugging lines to check received parameters
Write-Host "Received ImageType: $ImageType"
Write-Host "Received ManagedImageName: $ManagedImageName"

# Convert parameters to JSON body directly to avoid reliance on environment variables
$Body = @{
    definitionId = $DefinitionId
    variables = @{
      ImageBuildId = @{ value = $BuildId }
      ImageType = @{ value = $ImageType }
      ManagedImageName = @{ value = $ManagedImageName }
    }
    isDraft = $false
} | ConvertTo-Json -Depth 5

$URL = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=6.0"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":${AccessToken}"))
$headers = @{
    Authorization = "Basic $base64AuthInfo"
}

try {
    $NewRelease = Invoke-RestMethod $URL -Body $Body -Method Post -Headers $headers -ContentType "application/json"
    Write-Host "Created release: $($NewRelease._links.web.href)"
} catch {
    Write-Error "Failed to create release: $_"
}
