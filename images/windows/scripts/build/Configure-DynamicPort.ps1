################################################################################
##  File:  Configure-DynamicPort.ps1
##  Desc:  Configure dynamic port range for TCP and UDP to start at port 49152
##         and to end at the 65536 (16384 ports)
################################################################################

# https://support.microsoft.com/en-us/help/929851/the-default-dynamic-port-range-for-tcp-ip-has-changed-in-windows-vista
# The new default start port is 49152, and the new default end port is 65535.
# Default port configuration was changed during image generation by Visual Studio Enterprise Installer to:
#   Protocol tcp Dynamic Port Range
#   ---------------------------------
#   Start Port      : 1024
#   Number of Ports : 64511

Write-Host "Set the dynamic port range to start at port 49152 and to end at the 65536 (16384 ports)"
foreach ($ipVersion in @("ipv4", "ipv6")) {
    foreach ($protocol in @("tcp", "udp")) {
        $command = "netsh int $ipVersion set dynamicport $protocol start=49152 num=16384"
        Invoke-Expression $command | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Failed to set dynamic port range for $ipVersion $protocol"
            exit $LASTEXITCODE
        }
    }
}

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "DynamicPorts"
