# escape=`
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG INSTALL_USER=installer
USER ContainerAdministrator
RUN powershell -NoProfile -Command `
    "$ErrorActionPreference = 'Stop'; `
    $administrators = Get-LocalGroup -SID 'S-1-5-32-544'; `
    foreach ($name in @('packer', $env:INSTALL_USER) | Select-Object -Unique) { `
        $user = Get-LocalUser -Name $name -ErrorAction SilentlyContinue; `
        if (-not $user) { `
            if ($name -eq 'packer') { `
                $user = New-LocalUser -Name $name -NoPassword; `
                Set-LocalUser -Name $name -PasswordNeverExpires $true; `
            } else { `
                $password = ConvertTo-SecureString ('Pkr!' + [guid]::NewGuid().ToString('N')) -AsPlainText -Force; `
                $user = New-LocalUser -Name $name -Password $password -PasswordNeverExpires; `
            }; `
        }; `
        if (-not (Get-LocalGroupMember -Group $administrators | Where-Object { $_.SID -eq $user.SID })) { `
            Add-LocalGroupMember -Group $administrators -Member $user; `
        }; `
    }"

USER packer
RUN powershell -NoProfile -Command `
    "$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent(); `
    Write-Host ('Bootstrap process identity: ' + $identity.Name); `
    if ($identity.User -ne (Get-LocalUser -Name packer).SID) { throw 'Bootstrap process is not running as packer' }"
