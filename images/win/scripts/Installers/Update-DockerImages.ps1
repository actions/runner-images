################################################################################
##  File:  Update-DockerImages.ps1
##  Desc:  Pull some standard docker images.
##         Must be run after docker is installed.
################################################################################

function DockerPull {
    Param ([string]$image)

    Write-Host Installing $image ...
    docker pull $image

    if (!$?) {
      Write-Host "Docker pull failed with a non-zero exit code"
      exit 1
    }
}

# Temporary replace ip for download server to the more stable one
Copy-Item -Path "$env:windir\System32\drivers\etc\hosts" -Destination "C:\hosts_backup" -Verbose
"40.71.10.214 mcr.microsoft.com" >> "$env:windir\System32\drivers\etc\hosts"

$dockerToolset = (Get-ToolsetContent).docker
foreach($dockerImage in $dockerToolset.images) {
  DockerPull $dockerImage
}

Move-Item -Path "C:\hosts_backup" -Destination "$env:windir\System32\drivers\etc\hosts" -Force -Verbose
Invoke-PesterTests -TestFile "Docker" -TestName "DockerImages"