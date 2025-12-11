function Get-AzCopyVersion {
    $azcopyVersion = [string]$(azcopy --version) | Get-StringPart -Part 2
    return "$azcopyVersion - available by ``azcopy`` and ``azcopy10`` aliases"
}

function Get-BicepVersion {
    (bicep --version | Out-String) -match  "bicep cli version (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.Version
}

function Get-GitVersion {
    $gitVersion = git --version | Get-StringPart -Part -1
    return $gitVersion
}

function Get-GitLFSVersion {
    $result = Get-CommandResult "git-lfs --version"
    $gitlfsversion = $result.Output | Get-StringPart -Part 0 | Get-StringPart -Part 1 -Delimiter "/"
    return $gitlfsversion
}

function Get-GitFTPVersion {
    $gitftpVersion = git-ftp --version | Get-StringPart -Part 2
    return $gitftpVersion
}

function Get-GoogleCloudCLIVersion {
    return (gcloud --version | Select-Object -First 1) | Get-StringPart -Part 3
}

function Get-NvmVersion {
    $nvmVersion = bash -c "source /etc/skel/.nvm/nvm.sh && nvm --version"
    return $nvmVersion
}

function Get-JqVersion {
    $jqVersion = jq --version | Get-StringPart -Part 1 -Delimiter "-"
    return $jqVersion
}

function Get-AzureCliVersion {
    $azcliVersion = (az version | ConvertFrom-Json).'azure-cli'
    return $azcliVersion
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = (az version | ConvertFrom-Json).extensions.'azure-devops'
    return $azdevopsVersion
}

function Get-AWSCliVersion {
    $result = Get-CommandResult "aws --version"
    $awsVersion = $result.Output | Get-StringPart -Part 0 | Get-StringPart -Part 1 -Delimiter "/"
    return $awsVersion
}

function Get-AWSCliSessionManagerPluginVersion {
    $result = (Get-CommandResult "session-manager-plugin --version").Output
    return $result
}

function Get-AWSSAMVersion {
    return $(sam --version | Get-StringPart -Part -1)
}

function Get-GitHubCliVersion {
    $ghVersion = gh --version | Select-String "gh version" | Get-StringPart -Part 2
    return $ghVersion
}

function Get-ZstdVersion {
    $zstdVersion = zstd --version | Get-StringPart -Part 1 -Delimiter "v" | Get-StringPart -Part 0 -Delimiter ","
    return "$zstdVersion"
}

function Get-YqVersion {
    $yqVersion = $(yq -V) | Get-StringPart -Part 3
    return $yqVersion.TrimStart("v").Trim()
}
