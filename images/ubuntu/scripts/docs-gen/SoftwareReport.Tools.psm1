function Get-AnsibleVersion {
    $ansibleVersion = (ansible --version)[0] -replace "[^\d.]"
    return $ansibleVersion
}

function Get-AptFastVersion {
    $versionFileContent = Get-Content (which apt-fast) -Raw
    $match = [Regex]::Match($versionFileContent, '# apt-fast v(.+)\n')
    return $match.Groups[1].Value
}

function Get-AzCopyVersion {
    $azcopyVersion = [string]$(azcopy --version) | Get-StringPart -Part 2
    return "$azcopyVersion - available by ``azcopy`` and ``azcopy10`` aliases"
}

function Get-BazelVersion {
    $bazelVersion = bazel --version | Select-String "bazel" | Get-StringPart -Part 1
    return $bazelVersion
}

function Get-BazeliskVersion {
    $result = Get-CommandResult "bazelisk version" -Multiline
    $bazeliskVersion = $result.Output | Select-String "Bazelisk version:" | Get-StringPart -Part 2 | Get-StringPart -Part 0 -Delimiter "v"
    return $bazeliskVersion
}

function Get-BicepVersion {
    (bicep --version | Out-String) -match  "bicep cli version (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.Version
}

function Get-CodeQLBundleVersion {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
    $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
    $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
    $CodeQLVersion = & $CodeQLPath version --quiet
    return $CodeQLVersion
}

function Get-PodManVersion {
    $podmanVersion = podman --version | Get-StringPart -Part 2
    return $podmanVersion
}

function Get-BuildahVersion {
    $buildahVersion = buildah --version | Get-StringPart -Part 2
    return $buildahVersion
}

function Get-SkopeoVersion {
    $skopeoVersion = skopeo --version | Get-StringPart -Part 2
    return $skopeoVersion
}

function Get-CMakeVersion {
    $cmakeVersion = cmake --version | Select-Object -First 1 | Get-StringPart -Part 2
    return $cmakeVersion
}



function Get-DockerComposeV2Version {
    $composeVersion = docker compose version | Get-StringPart -Part 3 | Get-StringPart -Part 0 -Delimiter "v"
    return $composeVersion
}

function Get-DockerClientVersion {
    $dockerClientVersion = sudo docker version --format '{{.Client.Version}}'
    return $dockerClientVersion
}

function Get-DockerServerVersion {
    $dockerServerVersion = sudo docker version --format '{{.Server.Version}}'
    return $dockerServerVersion
}

function Get-DockerBuildxVersion {
    $buildxVersion = docker buildx version  | Get-StringPart -Part 1 | Get-StringPart -Part 0 -Delimiter "v"
    return $buildxVersion
}

function Get-DockerAmazonECRCredHelperVersion {
    $ecrVersion = docker-credential-ecr-login -v | Select-String "Version:" | Get-StringPart -Part 1
    return $ecrVersion
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

function Get-HavegedVersion {
    $havegedVersion = dpkg-query --showformat='${Version}' --show haveged | Get-StringPart -Part 0 -Delimiter "-"
    return $havegedVersion
}

function Get-HerokuVersion {
    $herokuVersion = heroku version | Get-StringPart -Part 0 | Get-StringPart -Part 1 -Delimiter "/"
    return $herokuVersion
}

function Get-HHVMVersion {
    $hhvmVersion = hhvm --version | Select-Object -First 1 | Get-StringPart -Part 2
    return $hhvmVersion
}

function Get-SVNVersion {
    $svnVersion = svn --version | Select-Object -First 1 | Get-StringPart -Part 2
    return $svnVersion
}

function Get-KustomizeVersion {
    $kustomizeVersion = kustomize version --short | Get-StringPart -Part 0 | Get-StringPart -Part 1 -Delimiter "v"
    return $kustomizeVersion
}

function Get-KindVersion {
    $kindVersion = kind version | Get-StringPart -Part 1 | Get-StringPart -Part 0 -Delimiter "v"
    return $kindVersion
}

function Get-KubectlVersion {
    $kubectlVersion = (kubectl version --client --output=json | ConvertFrom-Json).clientVersion.gitVersion.Replace('v','')
    return $kubectlVersion
}

function Get-MinikubeVersion {
    $minikubeVersion = minikube version --short | Get-StringPart -Part 0 -Delimiter "v"
    return $minikubeVersion
}

function Get-HGVersion {
    $hgVersion = hg --version | Select-Object -First 1 | Get-StringPart -Part -1 | Get-StringPart -Part 0 -Delimiter ")"
    return $hgVersion
}

function Get-LeiningenVersion {
    return "$(lein -v | Get-StringPart -Part 1)"
}

function Get-MediainfoVersion {
    $mediainfoVersion = (mediainfo --version | Select-Object -Index 1 | Get-StringPart -Part 2).Replace('v', '')
    return $mediainfoVersion
}

function Get-NewmanVersion {
    return $(newman --version)
}

function Get-NVersion {
    $nVersion = (n --version).Replace('v', '')
    return $nVersion
}

function Get-NvmVersion {
    $nvmVersion = bash -c "source /etc/skel/.nvm/nvm.sh && nvm --version"
    return $nvmVersion
}

function Get-PackerVersion {
    $packerVersion = (packer --version | Select-String "^Packer").Line.Replace('v','') | Get-StringPart -Part 1
    return $packerVersion
}

function Get-PhantomJSVersion {
    $env:OPENSSL_CONF="/etc/ssl"; phantomjs --version
    return $(phantomjs --version)
}

function Get-TerraformVersion {
    return (terraform version | Select-String "^Terraform").Line.Replace('v','') | Get-StringPart -Part 1
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

function Get-AlibabaCloudCliVersion {
    return $(aliyun version)
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

function Get-FastlaneVersion {
    $fastlaneVersion = fastlane --version | Select-String "^fastlane [0-9]" | Get-StringPart -Part 1
    return $fastlaneVersion
}

function Get-GitHubCliVersion {
    $ghVersion = gh --version | Select-String "gh version" | Get-StringPart -Part 2
    return $ghVersion
}

function Get-NetlifyCliVersion {
    $netlifyVersion = netlify --version | Get-StringPart -Part 0 | Get-StringPart -Part 1 -Delimiter "/"
    return $netlifyVersion
}

function Get-OCCliVersion {
    $ocVersion = oc version  -o=json | jq -r '.releaseClientVersion'
    return $ocVersion
}

function Get-ORASCliVersion {
    $orasVersion = oras version | Select-String "^Version:" | Get-StringPart -Part 1
    return $orasVersion
}

function Get-VerselCliversion {
    $result = Get-CommandResult "vercel --version" -Multiline
    return $result.Output | Select-Object -Skip 1 -First 1
}

function Get-PulumiVersion {
    $pulumiVersion = pulumi version | Get-StringPart -Part 0 -Delimiter "v"
    return $pulumiVersion
}

function Get-RVersion {
    $rVersion = (Get-CommandResult "R --version | grep 'R version'").Output |  Get-StringPart -Part 2
    return $rVersion
}

function Get-SphinxVersion {
    $sphinxVersion = searchd -h | Select-Object -First 1 | Get-StringPart -Part 1 | Get-StringPart -Part 0 -Delimiter "-"
    return $sphinxVersion
}

function Get-YamllintVersion {
    return $(yamllint --version) | Get-StringPart -Part 1
}

function Get-ZstdVersion {
    $zstdVersion = zstd --version | Get-StringPart -Part 1 -Delimiter "v" | Get-StringPart -Part 0 -Delimiter ","
    return "$zstdVersion"
}

function Get-YqVersion {
    $yqVersion = $(yq -V) | Get-StringPart -Part 3
    return $yqVersion.TrimStart("v").Trim()
}
