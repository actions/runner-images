$os = Get-CimInstance -ClassName Win32_OperatingSystem
$caption = $os.Caption
$osName = $caption.Substring(0, $caption.LastIndexOf(" "))
$osEdition = $caption.Substring($caption.LastIndexOf(" ")+1)
$osVersion = $os.Version
$imageVersion = $env:IMAGE_VERSION
$imageDataFile = $env:IMAGEDATA_FILE
$githubUrl="https://github.com/actions/runner-images/blob"

if (Test-IsWin22) {
    $imageLabel = "windows-2022"
    $softwareUrl = "${githubUrl}/win22/${imageVersion}/images/win/Windows2022-Readme.md"
    $releaseUrl="https://github.com/actions/runner-images/releases/tag/win22%2F${imageVersion}"
} elseif (Test-IsWin19) {
    $imageLabel = "windows-2019"
    $softwareUrl = "${githubUrl}/win19/${imageVersion}/images/win/Windows2019-Readme.md"
    $releaseUrl="https://github.com/actions/runner-images/releases/tag/win19%2F${imageVersion}"
} else {
    throw "Invalid platform version is found. Either Windows Server 2019 or 2022 are required"
}

$json = @"
[
  {
    "group": "Operating System",
    "detail": "${osName}\n${osVersion}\n${osEdition}"
  },
  {
    "group": "Runner Image",
    "detail": "Image: ${imageLabel}\nVersion: ${imageVersion}\nIncluded Software: ${softwareUrl}\nImage Release: ${releaseUrl}"
  }
]
"@

$json | Out-File -FilePath $imageDataFile


# Set static env vars
setx ImageVersion $env:IMAGE_VERSION /m
setx ImageOS $env:IMAGE_OS /m
setx AGENT_TOOLSDIRECTORY $env:AGENT_TOOLSDIRECTORY /m