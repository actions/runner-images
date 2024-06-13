
param (
    [String] $jsonString
)

$json = $jsonString | ConvertFrom-Json
foreach($prop in $json.psobject.properties) {
    Write-Host("##vso[task.setvariable variable=$($prop.Name);]$($prop.Value.value)")
}