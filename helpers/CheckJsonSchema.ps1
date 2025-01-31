$ErrorActionPreference = 'Stop'

# A JSON schema validator which supports outputting line numbers for errors
# this allows us to put annotations on builds for errors in the JSON files
# `Test-Json` built in cmdline doesn't. No existing cli tool supports this
# that I could find either. See: https://github.com/lawrencegripper/gripdev-json-schema-validator
Install-Module -Name GripDevJsonSchemaValidator -Force -Scope CurrentUser

# Find all toolset JSON files
$toolsetFiles = Get-ChildItem -Recurse -Filter "toolset-*.json" | Where-Object { $_.Name -notlike "*schema.json" }
$schemaFilePath = "./schemas/toolset-schema.json"

$toolsetHasErrors = $false
foreach ($file in $toolsetFiles) {
    Write-Host ""
    Write-Host "🔍 Validating $($file.FullName)" -ForegroundColor Cyan

    $validationResult = Test-JsonSchema -SchemaPath $schemaFilePath -JsonPath $file.FullName -PrettyPrint $false

    if ($validationResult.Valid) {
        Write-Host "✅ JSON is valid." -ForegroundColor Green
    } else {
        # File has been modified since the commit, enforce validation
        $toolsetHasErrors = $true
        Write-Host "`n❌ JSON validation failed!" -ForegroundColor Red
        Write-Host "   Found the following errors:`n" -ForegroundColor Yellow

        $validationResult.Errors | ForEach-Object {
            Write-Host $_.UserMessage
            if ($env:GITHUB_ACTIONS -eq 'true') {
                Write-Host "Adding annotation"
                Write-Host "::error file=$($file.Name),line=$($_.LineNumber)::$($_.UserMessage.Replace("`n", '%0A'))"
            }
        }
    }
}

if ($toolsetHasErrors) {
    Write-Error "One or more toolset JSON files failed schema validation. See the error output above for more details."
} else {
    Write-Host "Schema validation completed successfully"
}
