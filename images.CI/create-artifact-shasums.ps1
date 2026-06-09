Param
(
    [Parameter(Mandatory)]
    [string] $ArtifactsDirectory,

    [string] $ManifestName = "SHA256SUMS"
)

$ErrorActionPreference = "Stop"

$pathTrimCharacters = [char[]] @(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
)

$resolvedArtifactsDirectory = Resolve-Path -LiteralPath $ArtifactsDirectory
$artifactsDirectoryPath = $resolvedArtifactsDirectory.ProviderPath.TrimEnd($pathTrimCharacters)
$manifestPath = Join-Path $artifactsDirectoryPath $ManifestName

if (Test-Path -LiteralPath $manifestPath) {
    Remove-Item -LiteralPath $manifestPath -Force
}

$manifestLines = @(
    Get-ChildItem -LiteralPath $artifactsDirectoryPath -File -Recurse |
    Sort-Object -Property FullName |
    ForEach-Object {
        $relativePath = $_.FullName.Substring($artifactsDirectoryPath.Length)
        $relativePath = $relativePath.TrimStart($pathTrimCharacters)
        $relativePath = $relativePath.Replace([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)

        $hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        "$hash  $relativePath"
    }
)

$utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllLines($manifestPath, [string[]] $manifestLines, $utf8NoBomEncoding)

Write-Host "Created SHA256 manifest at $manifestPath"
