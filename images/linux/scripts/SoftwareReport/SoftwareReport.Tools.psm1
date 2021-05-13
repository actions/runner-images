function Get-AnsibleVersion {
    $ansibleVersion = ansible --version | Select-Object -First 1 | Take-OutputPart -Part 1
    return "Ansible $ansibleVersion"
}

function Get-AptFastVersion {
    $aptFastVersion = (dpkg-query --showformat='${Version}' --show apt-fast).Split('-')[0]
    return "apt-fast $aptFastVersion"
}

function Get-AzCopyVersion {
    $azcopyVersion = azcopy --version | Take-OutputPart -Part 2
    return "AzCopy $azcopyVersion (available by ``azcopy`` and ``azcopy10`` aliases)"
}

function Get-BazelVersion {
    $bazelVersion = bazel --version | Select-String "bazel" | Take-OutputPart -Part 1
    return "Bazel $bazelVersion"
}

function Get-BazeliskVersion {
    $result = Get-CommandResult "bazelisk version" -Multiline
    $bazeliskVersion = $result.Output | Select-String "Bazelisk version:" | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Bazelisk $bazeliskVersion"
}

function Get-CodeQLBundleVersion {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
    $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
    $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
    $CodeQLVersion = & $CodeQLPath version --quiet
    return "CodeQL Action Bundle $CodeQLVersion"
}

function Get-PodManVersion {
    $podmanVersion = podman --version | Take-OutputPart -Part 2
    $aptSourceRepo = Get-AptSourceRepository -PackageName "containers"
    return "Podman $podmanVersion (apt source repository: $aptSourceRepo)"
}

function Get-BuildahVersion {
    $buildahVersion = buildah --version | Take-OutputPart -Part 2
    $aptSourceRepo = Get-AptSourceRepository -PackageName "containers"
    return "Buildah $buildahVersion (apt source repository: $aptSourceRepo)"
}

function Get-SkopeoVersion {
    $skopeoVersion = skopeo --version | Take-OutputPart -Part 2
    $aptSourceRepo = Get-AptSourceRepository -PackageName "containers"
    return "Skopeo $skopeoVersion (apt source repository: $aptSourceRepo)"
}

function Get-CMakeVersion {
    $cmakeVersion = cmake --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "CMake $cmakeVersion"
}

function Get-DockerComposeVersion {
    $composeVersion = docker-compose -v | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter ","
    return "Docker Compose $composeVersion"
}

function Get-DockerMobyClientVersion {
    $dockerClientVersion = sudo docker version --format '{{.Client.Version}}'
    return "Docker-Moby Client $dockerClientVersion"
}

function Get-DockerMobyServerVersion {
    $dockerServerVersion = sudo docker version --format '{{.Server.Version}}'
    return "Docker-Moby Server $dockerServerVersion"
}

function Get-DockerBuildxVersion {
    $buildxVersion = docker buildx version  | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "+"
    return "Docker-Buildx $buildxVersion"
}

function Get-GitVersion {
    $result = Get-CommandResult "git --version"
    $gitVersion = $result.Output | Take-OutputPart -Part 2
    $aptSourceRepo = Get-AptSourceRepository -PackageName "git-core"
    return "Git $gitVersion (apt source repository: $aptSourceRepo)"
}

function Get-GitLFSVersion {
    $result = Get-CommandResult "git-lfs --version"
    $gitlfsversion = $result.Output | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    $aptSourceRepo = Get-AptSourceRepository -PackageName "git-lfs"
    return "Git LFS $gitlfsversion (apt source repository: $aptSourceRepo)"
}

function Get-GitFTPVersion {
    $gitftpVersion = git-ftp --version | Take-OutputPart -Part 2
    return "Git-ftp $gitftpVersion"
}

function Get-GoogleCloudSDKVersion {
    $aptSourceRepo = Get-AptSourceRepository -PackageName "google-cloud-sdk"
    return "$(gcloud --version | Select-Object -First 1) (apt source repository: $aptSourceRepo)"
}

function Get-HavegedVersion {
    $havegedVersion = dpkg-query --showformat='${Version}' --show haveged | Take-OutputPart -Part 0 -Delimiter "-"
    return "Haveged $havegedVersion"
}

function Get-HerokuVersion {
    $herokuVersion = heroku version | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "Heroku $herokuVersion"
}

function Get-HHVMVersion {
    $hhvmVersion = hhvm --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "HHVM (HipHop VM) $hhvmVersion"
}

function Get-SVNVersion {
    $svnVersion = svn --version | Select-Object -First 1 | Take-OutputPart -Part 2
    return "SVN $svnVersion"
}

function Get-KustomizeVersion {
    $kustomizeVersion = kustomize version --short | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "v"
    return "Kustomize $kustomizeVersion"
}

function Get-KindVersion {
    $kindVersion = kind version | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Kind $kindVersion"
}

function Get-KubectlVersion {
    $kubectlVersion = kubectl version --client --short | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "v"
    return "Kubectl $kubectlVersion"
}

function Get-MinikubeVersion {
    $minikubeVersion = minikube version --short | Take-OutputPart -Part 0 -Delimiter "v"
    return "Minikube $minikubeVersion"
}

function Get-HGVersion {
    $hgVersion = hg --version | Select-Object -First 1 | Take-OutputPart -Part -1 | Take-OutputPart -Part 0 -Delimiter ")"
    return "Mercurial $hgVersion"
}

function Get-LeiningenVersion {
    return "$(lein -v | Take-OutputPart -Part 0,1)"
}

function Get-MediainfoVersion {
    $mediainfoVersion = (mediainfo --version | Select-Object -Index 1 | Take-OutputPart -Part 2).Replace('v', '')
    return "MediaInfo $mediainfoVersion"
}

function Get-NewmanVersion {
    return "Newman $(newman --version)"
}

function Get-NvmVersion {
    $nvmVersion = bash -c "source /etc/skel/.nvm/nvm.sh && nvm --version"
    return "nvm $nvmVersion"
}

function Get-PackerVersion {
    # Packer 1.7.1 has a bug and outputs version to stderr instead of stdout https://github.com/hashicorp/packer/issues/10855
    $result = (Get-CommandResult -Command "packer --version").Output
    $packerVersion = [regex]::matches($result, "(\d+.){2}\d+").Value
    return "Packer $packerVersion"
}

function Get-PhantomJSVersion {
    return "PhantomJS $(phantomjs --version)"
}

function Get-TerraformVersion {
    return (terraform version | Select-String "^Terraform").Line.Replace('v','')
}

function Get-JqVersion {
    $jqVersion = jq --version | Take-OutputPart -Part 1 -Delimiter "-"
    return "jq $jqVersion"
}

function Get-AzureCliVersion {
    $azcliVersion = az -v | Select-String "azure-cli" | Take-OutputPart -Part -1
    $aptSourceRepo = Get-AptSourceRepository -PackageName "azure-cli"
    return "Azure CLI (azure-cli) $azcliVersion (installation method: $aptSourceRepo)"
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = az -v | Select-String "azure-devops" | Take-OutputPart -Part -1
    return "Azure CLI (azure-devops) $azdevopsVersion"
}

function Get-AlibabaCloudCliVersion {
    return "Alibaba Cloud CLI $(aliyun version)"
}

function Get-AWSCliVersion {
    $result = Get-CommandResult "aws --version"
    $awsVersion = $result.Output | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "AWS CLI $awsVersion"
}

function Get-AWSCliSessionManagerPluginVersion {
    $result = (Get-CommandResult "session-manager-plugin --version").Output
    return "AWS CLI Session manager plugin $result"
}

function Get-AWSSAMVersion {
    return "AWS SAM CLI $(sam --version | Take-OutputPart -Part -1)"
}

function Get-FastlaneVersion {
    $fastlaneVersion = fastlane --version | Select-String "^fastlane [0-9]" | Take-OutputPart -Part 1
    return "Fastlane $fastlaneVersion"
}

function Get-HubCliVersion {
    $hubVersion = hub --version | Select-String "hub version" | Take-OutputPart -Part 2
    return "Hub CLI $hubVersion"
}

function Get-GitHubCliVersion {
    $ghVersion = gh --version | Select-String "gh version" | Take-OutputPart -Part 2
    return "GitHub CLI $ghVersion"
}

function Get-NetlifyCliVersion {
    $netlifyVersion = netlify --version | Take-OutputPart -Part 0 | Take-OutputPart -Part 1 -Delimiter "/"
    return "Netlify CLI $netlifyVersion"
}

function Get-OCCliVersion {
    $ocVersion = oc version | Take-OutputPart -Part 2 | Take-OutputPart -Part 0 -Delimiter "-"
    return "OpenShift CLI $ocVersion"
}

function Get-ORASCliVersion {
    $orasVersion = oras version | Select-String "^Version:" | Take-OutputPart -Part 1
    return "ORAS CLI $orasVersion"
}

function Get-VerselCliversion {
    $result = Get-CommandResult "vercel --version" -Multiline
    return $result.Output | Select-Object -First 1
}

function Get-PulumiVersion {
    $pulumiVersion = pulumi version | Take-OutputPart -Part 0 -Delimiter "v"
    return "Pulumi $pulumiVersion"
}

function Get-RVersion {
    $rVersion = (Get-CommandResult "R --version | grep 'R version'").Output |  Take-OutputPart -Part 2
    return "R $rVersion"
}

function Get-SphinxVersion {
    $sphinxVersion = searchd -h | Select-Object -First 1 | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "-"
    return "Sphinx Open Source Search Server $sphinxVersion"
}

function Get-YamllintVersion {
    return "$(yamllint --version)"
}

function Get-ZstdVersion {
    $zstdVersion = zstd --version | Take-OutputPart -Part 1 -Delimiter "v" | Take-OutputPart -Part 0 -Delimiter ","
    return "zstd $zstdVersion (homebrew)"
}
