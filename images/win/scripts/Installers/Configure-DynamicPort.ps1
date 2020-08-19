# https://support.microsoft.com/en-us/help/929851/the-default-dynamic-port-range-for-tcp-ip-has-changed-in-windows-vista
# The new default start port is 49152, and the new default end port is 65535.
Write-Host "Set the dynamic port range to start at port 49152 and to end at the 65536 (16384 ports)"
$null = netsh int ipv4 set dynamicport tcp start=49152 num=16384
$null = netsh int ipv4 set dynamicport udp start=49152 num=16384
$null = netsh int ipv6 set dynamicport tcp start=49152 num=16384
$null = netsh int ipv6 set dynamicport udp start=49152 num=16384

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "DynamicPorts"