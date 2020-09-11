function Get-7zipVersion {
    $7zVersion = 7z i | Select-String "7-Zip" | Take-Part -Part 2
    return "7-Zip $7zVersion"
}

function Get-AnsibleVersion {
    $ansibleVersion = ansible --version | Select-Object -First 1 | Take-Part -Part 1
    return "Ansible $ansibleVersion"
}

function Get-AzCopy7Version {
    $azcopy7Version = azcopy --version | Take-Part -Part 1 | Take-Part -Part 0 -Delimiter "-"
    return "AzCopy7 (available by azcopy alias) $azcopy7Version"
}

function Get-AzCopy10Version {
    $azcopy10Version = azcopy10 --version | Take-Part -Part 2
    return "AzCopy10 (available by azcopy10 alias) $azcopy10Version"
}

function Get-BazelVersion {
    $bazelVersion = bazel --version | Select-String "bazel" | Take-Part -Part 1
    return "Bazel $bazelVersion"
}

function Get-BazeliskVersion {
    $bazeliskVersion = bazelisk version 2>&1 | Select-String "Bazelisk version:" | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "v"
    return "Bazelisk $bazeliskVersion"
}

function Get-PodManVersion {
    $podmanVersion = podman --version | Take-Part -Part 2
    return "Podman $podmanVersion"
}

function Get-BuildahVersion {
    $buildahVersion = buildah --version | Take-Part -Part 2
    return "Buildah $buildahVersion"
}

function Get-SkopeoVersion {
    $skopeoVersion = skopeo --version | Take-Part -Part 2
    return "Skopeo $skopeoVersion"
}

function Get-CMakeVersion {
    $cmakeVersion = cmake --version | Select-Object -First 1 | Take-Part -Part 2
    return "CMake $cmakeVersion"
}

function Get-CurlVersion {
    $curlVersion = curl --version | Select-Object -First 1 | Take-Part -Part 0,1
    return $curlVersion
}

function Get-DockerComposeVersion {
    $composeVersion = docker-compose -v | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter ","
    return "Docker Compose $composeVersion"
}

function Get-DockerMobyVersion {
    $dockerVersion = docker -v | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "+"
    return "Docker-Moby $dockerVersion"
}

function Get-DockerBuildxVersion {
    $buildxVersion = docker buildx version  | Take-Part -Part 1 | Take-Part -Part 0 -Delimiter "+"
    return "Docker-Buildx $buildxVersion"
}

function Get-GitVersion {
    $gitVersion = git --version 2>&1 | Take-Part -Part 2
    return "Git $gitVersion"
}

function Get-GitLFSVersion {
    $gitlfsversion = git-lfs --version 2>&1 | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return "Git LFS $gitlfsversion"
}

function Get-GitFTPVersion {
    $gitftpVersion = git-ftp --version | Take-Part -Part 2
    return "Git-ftp $gitftpVersion"
}

function Get-GoogleCloudSDKVersion {
    return "$(gcloud --version | Select-Object -First 1)"
}

function Get-HavegedVersion {
    $havegedVersion = dpkg-query --showformat='${Version}' --show haveged | Take-Part -Part 0 -Delimiter "-"
    return "Haveged $havegedVersion"
}

function Get-HerokuVersion {
    $herokuVersion = heroku version | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return "Heroku $herokuVersion"
}

function Get-HHVMVersion {
    $hhvmVersion = hhvm --version | Select-Object -First 1 | Take-Part -Part 2
    return "HHVM (HipHop VM) $hhvmVersion"
}

function Get-SVNVersion {
    $svnVersion = svn --version | Select-Object -First 1 | Take-Part -Part 2
    return "SVN $svnVersion"
}

function Get-KustomizeVersion {
    $kustomizeVersion = kustomize version --short | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "v"
    return "Kustomize $kustomizeVersion"
}

function Get-KindVersion {
    $kindVersion = kind version | Take-Part -Part 1 | Take-Part -Part 0 -Delimiter "v"
    return "Kind $kindVersion"
}

function Get-KubectlVersion {
    $kubectlVersion = kubectl version --client --short | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "v"
    return "Kubectl $kubectlVersion"
}

function Get-MinikubeVersion {
    $minikubeVersion = minikube version --short | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "v"
    return "Minikube $minikubeVersion"
}

function Get-HGVersion {
    $hgVersion = hg --version | Select-Object -First 1 | Take-Part -Part -1 | Take-Part -Part 0 -Delimiter ")"
    return "Mercurial $hgVersion"
}

function Get-M4Version {
    $m4Version = m4 --version | Select-Object -First 1 | Take-Part -Part -1
    return "m4 $m4Version"
}

function Get-LeiningenVersion {
    return "$(lein -v | Take-Part -Part 0,1)"
}

function Get-NewmanVersion {
    return "Newman $(newman --version)"
}

function Get-NvmVersion {
    $nvmVersion = bash -c "source $HOME/.nvm/nvm.sh && nvm --version"
    return "nvm $nvmVersion"
}

function Get-PackerVersion {
    return "Packer $(packer --version)"
}

function Get-PhantomJSVersion {
    return "PhantomJS $(phantomjs --version)"
}

function Get-SwigVersion {
    $swigVersion = swig -version | Select-String "SWIG Version" | Take-Part -Part 2
    return "Swig $swigVersion"
}

function Get-TerraformVersion {
    return (terraform version | Select-String "^Terraform").Line.Replace('v','')
}

function Get-UnZipVersion {
    $unzipVersion = unzip -v | Select-Object -First 1 | Take-Part -Part 1
    return "unzip $unzipVersion"
}

function Get-WgetVersion {
    $wgetVersion = wget --version | Select-Object -First 1 | Take-Part -Part 2
    return "wget $wgetVersion"
}

function Get-ZipVersion {
    $zipVersion = zip -v | Select-String "This is Zip" | Take-Part -Part 3
    return "zip $zipVersion"
}

function Get-ZstdVersion {
    $zstdVersion = (zstd --version).Split() -match "v\d+" | ForEach-Object {$_.Replace("v","").Replace(",","")}
    return "zstd $zstdVersion"
}

function Get-JqVersion {
    $jqVersion = jq --version | Take-Part -Part 1 -Delimiter "-"
    return "jq $jqVersion"
}

function Get-AzureCliVersion {
    $azcliVersion = az -v | Select-String "azure-cli" | Take-Part -Part -1
    return "Azure CLI (azure-cli) $azcliVersion"
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = az -v | Select-String "azure-devops" | Take-Part -Part -1
    return "Azure CLI (azure-devops) $azdevopsVersion"
}

function Get-AlibabaCloudCliVersion {
    return "Alibaba Cloud CLI $(aliyun version)"
}

function Get-AWSCliVersion {
    $awsVersion = aws --version 2>&1 | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return "AWS CLI $awsVersion"
}

function Get-AWSCliSessionManagerPluginVersion {
    return "AWS CLI Session manager plugin $(session-manager-plugin --version 2>&1)"
}

function Get-AWSSAMVersion {
    return "AWS SAM CLI $(sam --version | Take-Part -Part -1)"
}

function Get-HubCliVersion {
    $hubVersion = hub --version | Select-String "hub version" | Take-Part -Part 2
    return "Hub CLI $hubVersion"
}

function Get-GitHubCliVersion {
    $ghVersion = gh --version | Select-String "gh version" | Take-Part -Part 2
    return "GitHub CLI $ghVersion"
}

function Get-NetlifyCliVersion {
    $netlifyVersion = netlify --version | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return "Netlify CLI $netlifyVersion"
}

function Get-OCCliVersion {
    $ocVersion = oc version | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "-"
    return "oc CLI $ocVersion"
}

function Get-ORASCliVersion {
    $orasVersion = oras version | Select-String "^Version:" | Take-Part -Part 1
    return "ORAS CLI $orasVersion"
}

function Get-VerselCliversion {
    return "$(vercel --version 2>&1 | Select-Object -First 1)"
}
