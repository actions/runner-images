if (Test-Path $Env:SystemRoot\\System32\\Sysprep\\unattend.xml)
{
  Remove-Item $Env:SystemRoot\\System32\\Sysprep\\unattend.xml -Force
}

try
{
  # Construct an AgentId as per https://github.com/hashicorp/packer/issues/9818
  $reg = New-Item "HKLM:\SOFTWARE\Microsoft\DesiredStateConfiguration"
  $reg.SetValue("AgentId","")
} catch {
  Write-Output "Unable to Patch DSC Registry Setting"
}
& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /mode:vm /quiet /quit

$fs = [System.IO.FileStream]::new("$ENV:SystemRoot\System32\Sysprep\Panther\Setuperr.log",
  [System.IO.FileMode]::Open,[System.IO.FileAccess]::Read,[System.IO.FileShare]::ReadWrite)
$reader = [System.IO.StreamReader]::new($fs)

$lastMaxOffset = $reader.BaseStream.Length

$undeployableCount = 0

while ($true) {
  $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select-Object ImageState;
  if ($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') {
    Write-Output $imageState.ImageState;
    # if log has advanced, write out new content to the Output
    if ($reader.BaseStream.Length -ne $lastMaxOffset) {
      $reader.BaseStream.Seek($lastMaxOffset,[System.IO.SeekOrigin]::Begin)
      $line = ""
      while ($null -ne ($line = $reader.ReadLine())) {
        Write-Output ("Setuperr: {0}" -f $line)
      }
      $lastMaxOffset = $reader.BaseStream.Position
    }
    # Handle the image being undeployable (this can be a temporary condition, 
    # but if it continues to be in this state it indicates a problem)
    if ($imageState.ImageState -eq "IMAGE_STATE_UNDEPLOYABLE") {
      if ($undeployableCount -gt 10) {
        Write-Output "Image appears to be unusable, bailing out";
        exit 1;
      }
      $undeployableCount++;
    }
    Start-Sleep -s 10
  }
  else {
    break
  }
}
