################################################################################
##  File:  Configure-ImageDataFile.ps1
##  Desc:  Creates a JSON file with information about the image
################################################################################

$os = Get-CimInstance -ClassName Win32_OperatingSystem
$caption = $os.Caption
$osName = $caption.Substring(0, $caption.LastIndexOf(" "))
$osEdition = $caption.Substring($caption.LastIndexOf(" ") + 1)
$osVersion = $os.Version
$imageVersion = $env:IMAGE_VERSION
$imageVersionComponents = $imageVersion.Split('.')
$imageMajorVersion = $imageVersionComponents[0]
$imageMinorVersion = $imageVersionComponents[1]
$imageDataFile = $env:IMAGEDATA_FILE
$githubUrl = "https://github.com/actions/runner-images/blob"

if (Test-IsWin25) {
  $imageLabel = "windows-2025"
  $softwareUrl = "${githubUrl}/win25/$imageMajorVersion.$imageMinorVersion/images/windows/Windows2025-Readme.md"
  $releaseUrl = "https://github.com/actions/runner-images/releases/tag/win25%2F$imageMajorVersion.$imageMinorVersion"
} elseif (Test-IsWin22) {
    $imageLabel = "windows-2022"
    $softwareUrl = "${githubUrl}/win22/$imageMajorVersion.$imageMinorVersion/images/windows/Windows2022-Readme.md"
    $releaseUrl = "https://github.com/actions/runner-images/releases/tag/win22%2F$imageMajorVersion.$imageMinorVersion"
} elseif (Test-IsWin19) {
    $imageLabel = "windows-2019"
    $softwareUrl = "${githubUrl}/win19/$imageMajorVersion.$imageMinorVersion/images/windows/Windows2019-Readme.md"
    $releaseUrl = "https://github.com/actions/runner-images/releases/tag/win19%2F$imageMajorVersion.$imageMinorVersion"
} else {
    throw "Invalid platform version is found. Either Windows Server 2019, 2022 or 2025 are required"
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
