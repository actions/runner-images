$os = Get-CimInstance -ClassName Win32_OperatingSystem
$caption = $os.Caption
$osName = $caption.Substring(0, $caption.LastIndexOf(" "))
$osEdition = $caption.Substring($caption.LastIndexOf(" ")+1)
$osVersion = $os.Version
$imageVersion = $env:IMAGE_VERSION
$imageDataFile = $env:IMAGEDATA_FILE
$githubUrl="https://github.com/actions/virtual-environments/blob"

if ($caption -match "2022") {
    $imageLabel = "windows-2022"
    $softwareUrl = "${githubUrl}/win22/${imageVersion}/images/win/Windows2022-Readme.md"
    $releaseUrl="https://github.com/actions/virtual-environments/releases/tag/win22%2F${imageVersion}"
} elseif ($caption -match "2019") {
    $imageLabel = "windows-2019"
    $softwareUrl = "${githubUrl}/win19/${imageVersion}/images/win/Windows2019-Readme.md"
    $releaseUrl="https://github.com/actions/virtual-environments/releases/tag/win19%2F${imageVersion}"
} elseif ($caption -match "2016") {
    $imageLabel = "windows-2016"
    $softwareUrl = "${githubUrl}/win16/${imageVersion}/images/win/Windows2016-Readme.md"
    $releaseUrl="https://github.com/actions/virtual-environments/releases/tag/win16%2F${imageVersion}"
}

$json = @"
[
  {
    "group": "Operating System",
    "detail": "${osName}\n${osVersion}\n${osEdition}"
  },
  {
    "group": "Virtual Environment",
    "detail": "Environment: ${imageLabel}\nVersion: ${imageVersion}\nIncluded Software: ${softwareUrl}\nImage Release: ${releaseUrl}"
  }
]
"@

$json | Out-File -FilePath $imageDataFile
