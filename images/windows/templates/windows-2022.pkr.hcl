packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "1.4.5"
    }
  }
}

locals {
  managed_image_name = var.managed_image_name != "" ? var.managed_image_name : "packer-${var.image_os}-${var.image_version}"
}

variable "agent_tools_directory" {
  type    = string
  default = "C:\\hostedtoolcache\\windows"
}

variable "allowed_inbound_ip_addresses" {
  type    = list(string)
  default = []
}

variable "azure_tags" {
  type    = map(string)
  default = {}
}

variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RESOURCE_GROUP_NAME")}"
}

variable "client_cert_path" {
  type    = string
  default = "${env("ARM_CLIENT_CERT_PATH")}"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type      = string
  default   = "${env("ARM_CLIENT_SECRET")}"
  sensitive = true
}

variable "helper_script_folder" {
  type    = string
  default = "C:\\Program Files\\WindowsPowerShell\\Modules\\"
}

variable "image_folder" {
  type    = string
  default = "C:\\image"
}

variable "image_os" {
  type    = string
  default = "win22"
}

variable "image_version" {
  type    = string
  default = "dev"
}

variable "imagedata_file" {
  type    = string
  default = "C:\\imagedata.json"
}

variable "install_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "install_user" {
  type    = string
  default = "installer"
}

variable "location" {
  type    = string
  default = "${env("ARM_RESOURCE_LOCATION")}"
}

variable "managed_image_name" {
  type    = string
  default = ""
}

variable "managed_image_resource_group_name" {
  type    = string
  default = "${env("ARM_RESOURCE_GROUP")}"
}

variable "managed_image_storage_account_type" {
  type    = string
  default = "Premium_LRS"
}

variable "object_id" {
  type    = string
  default = "${env("ARM_OBJECT_ID")}"
}

variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = false
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "virtual_network_name" {
  type    = string
  default = "${env("VNET_NAME")}"
}

variable "virtual_network_resource_group_name" {
  type    = string
  default = "${env("VNET_RESOURCE_GROUP")}"
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "${env("VNET_SUBNET")}"
}

variable "vm_size" {
  type    = string
  default = "Standard_F8s_v2"
}

source "azure-arm" "image" {
  allowed_inbound_ip_addresses           = "${var.allowed_inbound_ip_addresses}"
  build_resource_group_name              = "${var.build_resource_group_name}"
  client_cert_path                       = "${var.client_cert_path}"
  client_id                              = "${var.client_id}"
  client_secret                          = "${var.client_secret}"
  communicator                           = "winrm"
  image_offer                            = "WindowsServer"
  image_publisher                        = "MicrosoftWindowsServer"
  image_sku                              = "2022-Datacenter"
  location                               = "${var.location}"
  managed_image_name                     = "${local.managed_image_name}"
  managed_image_resource_group_name      = "${var.managed_image_resource_group_name}"
  managed_image_storage_account_type     = "${var.managed_image_storage_account_type}"
  object_id                              = "${var.object_id}"
  os_disk_size_gb                        = "256"
  os_type                                = "Windows"
  private_virtual_network_with_public_ip = "${var.private_virtual_network_with_public_ip}"
  subscription_id                        = "${var.subscription_id}"
  temp_resource_group_name               = "${var.temp_resource_group_name}"
  tenant_id                              = "${var.tenant_id}"
  virtual_network_name                   = "${var.virtual_network_name}"
  virtual_network_resource_group_name    = "${var.virtual_network_resource_group_name}"
  virtual_network_subnet_name            = "${var.virtual_network_subnet_name}"
  vm_size                                = "${var.vm_size}"
  winrm_insecure                         = "true"
  winrm_use_ssl                          = "true"
  winrm_username                         = "packer"

  dynamic "azure_tag" {
    for_each = var.azure_tags
    content {
      name  = azure_tag.key
      value = azure_tag.value
    }
  }
}

build {
  sources = ["source.azure-arm.image"]

  provisioner "powershell" {
    inline = ["New-Item -Path ${var.image_folder} -ItemType Directory -Force"]
  }

  provisioner "file" {
    destination = "${var.image_folder}\\"
    sources     = [
      "${path.root}/../assets",
      "${path.root}/../scripts",
      "${path.root}/../toolsets"
    ]
  }

  provisioner "file" {
    destination = "${var.image_folder}\\scripts\\docs-gen\\"
    source      = "${path.root}/../../../helpers/software-report-base"
  }

  provisioner "powershell" {
    inline = [
      "Move-Item '${var.image_folder}\\assets\\post-gen' 'C:\\post-generation'",
      "Remove-Item -Recurse '${var.image_folder}\\assets'",
      "Move-Item '${var.image_folder}\\scripts\\docs-gen' '${var.image_folder}\\SoftwareReport'",
      "Move-Item '${var.image_folder}\\scripts\\helpers' '${var.helper_script_folder}\\ImageHelpers'",
      "New-Item -Type Directory -Path '${var.helper_script_folder}\\TestsHelpers\\'",
      "Move-Item '${var.image_folder}\\scripts\\tests\\Helpers.psm1' '${var.helper_script_folder}\\TestsHelpers\\TestsHelpers.psm1'",
      "Move-Item '${var.image_folder}\\scripts\\tests' '${var.image_folder}\\tests'",
      "Remove-Item -Recurse '${var.image_folder}\\scripts'",
      "Move-Item '${var.image_folder}\\toolsets\\toolset-2022.json' '${var.image_folder}\\toolset.json'",
      "Remove-Item -Recurse '${var.image_folder}\\toolsets'"
    ]
  }

  provisioner "windows-shell" {
    inline = [
      "net user ${var.install_user} ${var.install_password} /add /passwordchg:no /passwordreq:yes /active:yes /Y",
      "net localgroup Administrators ${var.install_user} /add",
      "winrm set winrm/config/service/auth @{Basic=\"true\"}",
      "winrm get winrm/config/service/auth"
    ]
  }

  provisioner "powershell" {
    inline = ["if (-not ((net localgroup Administrators) -contains '${var.install_user}')) { exit 1 }"]
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    inline            = ["bcdedit.exe /set TESTSIGNING ON"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGE_OS=${var.image_os}", "AGENT_TOOLSDIRECTORY=${var.agent_tools_directory}", "IMAGEDATA_FILE=${var.imagedata_file}", "IMAGE_FOLDER=${var.image_folder}"]
    execution_policy = "unrestricted"
    scripts          = [
      "${path.root}/../scripts/build/Configure-WindowsDefender.ps1",
      "${path.root}/../scripts/build/Configure-PowerShell.ps1",
      "${path.root}/../scripts/build/Install-PowerShellModules.ps1",
      "${path.root}/../scripts/build/Install-WindowsFeatures.ps1",
      "${path.root}/../scripts/build/Install-Chocolatey.ps1",
      "${path.root}/../scripts/build/Configure-BaseImage.ps1",
      "${path.root}/../scripts/build/Configure-ImageDataFile.ps1",
      "${path.root}/../scripts/build/Configure-SystemEnvironment.ps1",
      "${path.root}/../scripts/build/Configure-DotnetSecureChannel.ps1"
    ]
  }

  provisioner "windows-restart" {
    check_registry        = true
    restart_check_command = "powershell -command \"& {while ( (Get-WindowsOptionalFeature -Online -FeatureName Containers -ErrorAction SilentlyContinue).State -ne 'Enabled' ) { Start-Sleep 30; Write-Output 'InProgress' }}\""
    restart_timeout       = "10m"
  }

  provisioner "powershell" {
    inline = ["Set-Service -Name wlansvc -StartupType Manual", "if ($(Get-Service -Name wlansvc).Status -eq 'Running') { Stop-Service -Name wlansvc}"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts          = [
      "${path.root}/../scripts/build/Install-Docker.ps1",
      "${path.root}/../scripts/build/Install-DockerWinCred.ps1",
      "${path.root}/../scripts/build/Install-DockerCompose.ps1",
      "${path.root}/../scripts/build/Install-PowershellCore.ps1",
      "${path.root}/../scripts/build/Install-WebPlatformInstaller.ps1",
      "${path.root}/../scripts/build/Install-Runner.ps1",
      "${path.root}/../scripts/build/Install-TortoiseSvn.ps1"
    ]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    environment_vars  = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts           = [
      "${path.root}/../scripts/build/Install-VisualStudio.ps1",
      "${path.root}/../scripts/build/Install-KubernetesTools.ps1"
    ]
    valid_exit_codes  = [0, 3010]
  }

  provisioner "windows-restart" {
    check_registry  = true
    restart_timeout = "10m"
  }

  provisioner "powershell" {
    pause_before     = "2m0s"
    environment_vars = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts          = [
      "${path.root}/../scripts/build/Install-Wix.ps1",
      "${path.root}/../scripts/build/Install-WDK.ps1",
      "${path.root}/../scripts/build/Install-VSExtensions.ps1",
      "${path.root}/../scripts/build/Install-AzureCli.ps1",
      "${path.root}/../scripts/build/Install-AzureDevOpsCli.ps1",
      "${path.root}/../scripts/build/Install-ChocolateyPackages.ps1",
      "${path.root}/../scripts/build/Install-JavaTools.ps1",
      "${path.root}/../scripts/build/Install-Kotlin.ps1",
      "${path.root}/../scripts/build/Install-OpenSSL.ps1"
    ]
  }

  provisioner "powershell" {
    execution_policy = "remotesigned"
    environment_vars = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts          = ["${path.root}/../scripts/build/Install-ServiceFabricSDK.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "10m"
  }

  provisioner "windows-shell" {
    inline = ["wmic product where \"name like '%%microsoft azure powershell%%'\" call uninstall /nointeractive"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts          = [
      "${path.root}/../scripts/build/Install-ActionsCache.ps1",
      "${path.root}/../scripts/build/Install-Ruby.ps1",
      "${path.root}/../scripts/build/Install-PyPy.ps1",
      "${path.root}/../scripts/build/Install-Toolset.ps1",
      "${path.root}/../scripts/build/Configure-Toolset.ps1",
      "${path.root}/../scripts/build/Install-NodeJS.ps1",
      "${path.root}/../scripts/build/Install-AndroidSDK.ps1",
      "${path.root}/../scripts/build/Install-PowershellAzModules.ps1",
      "${path.root}/../scripts/build/Install-Pipx.ps1",
      "${path.root}/../scripts/build/Install-Git.ps1",
      "${path.root}/../scripts/build/Install-GitHub-CLI.ps1",
      "${path.root}/../scripts/build/Install-PHP.ps1",
      "${path.root}/../scripts/build/Install-Rust.ps1",
      "${path.root}/../scripts/build/Install-Sbt.ps1",
      "${path.root}/../scripts/build/Install-Chrome.ps1",
      "${path.root}/../scripts/build/Install-EdgeDriver.ps1",
      "${path.root}/../scripts/build/Install-Firefox.ps1",
      "${path.root}/../scripts/build/Install-Selenium.ps1",
      "${path.root}/../scripts/build/Install-IEWebDriver.ps1",
      "${path.root}/../scripts/build/Install-Apache.ps1",
      "${path.root}/../scripts/build/Install-Nginx.ps1",
      "${path.root}/../scripts/build/Install-Msys2.ps1",
      "${path.root}/../scripts/build/Install-WinAppDriver.ps1",
      "${path.root}/../scripts/build/Install-R.ps1",
      "${path.root}/../scripts/build/Install-AWSTools.ps1",
      "${path.root}/../scripts/build/Install-DACFx.ps1",
      "${path.root}/../scripts/build/Install-MysqlCli.ps1",
      "${path.root}/../scripts/build/Install-SQLPowerShellTools.ps1",
      "${path.root}/../scripts/build/Install-SQLOLEDBDriver.ps1",
      "${path.root}/../scripts/build/Install-DotnetSDK.ps1",
      "${path.root}/../scripts/build/Install-Mingw64.ps1",
      "${path.root}/../scripts/build/Install-Haskell.ps1",
      "${path.root}/../scripts/build/Install-Stack.ps1",
      "${path.root}/../scripts/build/Install-Miniconda.ps1",
      "${path.root}/../scripts/build/Install-AzureCosmosDbEmulator.ps1",
      "${path.root}/../scripts/build/Install-Mercurial.ps1",
      "${path.root}/../scripts/build/Install-Zstd.ps1",
      "${path.root}/../scripts/build/Install-NSIS.ps1",
      "${path.root}/../scripts/build/Install-Vcpkg.ps1",
      "${path.root}/../scripts/build/Install-PostgreSQL.ps1",
      "${path.root}/../scripts/build/Install-Bazel.ps1",
      "${path.root}/../scripts/build/Install-AliyunCli.ps1",
      "${path.root}/../scripts/build/Install-RootCA.ps1",
      "${path.root}/../scripts/build/Install-MongoDB.ps1",
      "${path.root}/../scripts/build/Install-CodeQLBundle.ps1",
      "${path.root}/../scripts/build/Configure-Diagnostics.ps1"
    ]
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    environment_vars  = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts           = [
      "${path.root}/../scripts/build/Install-WindowsUpdates.ps1",
      "${path.root}/../scripts/build/Configure-DynamicPort.ps1",
      "${path.root}/../scripts/build/Configure-GDIProcessHandleQuota.ps1",
      "${path.root}/../scripts/build/Configure-Shell.ps1",
      "${path.root}/../scripts/build/Configure-DeveloperMode.ps1",
      "${path.root}/../scripts/build/Install-LLVM.ps1"
    ]
  }

  provisioner "windows-restart" {
    check_registry        = true
    restart_check_command = "powershell -command \"& {if ((-not (Get-Process TiWorker.exe -ErrorAction SilentlyContinue)) -and (-not [System.Environment]::HasShutdownStarted) ) { Write-Output 'Restart complete' }}\""
    restart_timeout       = "30m"
  }

  provisioner "powershell" {
    pause_before     = "2m0s"
    environment_vars = ["IMAGE_FOLDER=${var.image_folder}"]
    scripts          = [
      "${path.root}/../scripts/build/Install-WindowsUpdatesAfterReboot.ps1",
      "${path.root}/../scripts/tests/RunAll-Tests.ps1"
    ]
  }

  provisioner "powershell" {
    inline = ["if (-not (Test-Path ${var.image_folder}\\tests\\testResults.xml)) { throw '${var.image_folder}\\tests\\testResults.xml not found' }"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGE_FOLDER=${var.image_folder}"]
    inline           = ["pwsh -File '${var.image_folder}\\SoftwareReport\\Generate-SoftwareReport.ps1'"]
  }

  provisioner "powershell" {
    inline = ["if (-not (Test-Path C:\\software-report.md)) { throw 'C:\\software-report.md not found' }", "if (-not (Test-Path C:\\software-report.json)) { throw 'C:\\software-report.json not found' }"]
  }

  provisioner "file" {
    destination = "${path.root}/../Windows2022-Readme.md"
    direction   = "download"
    source      = "C:\\software-report.md"
  }

  provisioner "file" {
    destination = "${path.root}/../software-report.json"
    direction   = "download"
    source      = "C:\\software-report.json"
  }

  provisioner "powershell" {
    environment_vars = ["INSTALL_USER=${var.install_user}"]
    scripts          = [
      "${path.root}/../scripts/build/Install-NativeImages.ps1",
      "${path.root}/../scripts/build/Configure-System.ps1",
      "${path.root}/../scripts/build/Configure-User.ps1"
    ]
    skip_clean       = true
  }

  provisioner "windows-restart" {
    restart_timeout = "10m"
  }

  provisioner "powershell" {
    inline = [
      "if( Test-Path $env:SystemRoot\\System32\\Sysprep\\unattend.xml ){ rm $env:SystemRoot\\System32\\Sysprep\\unattend.xml -Force}",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /mode:vm /quiet /quit",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10 } else { break } }"
    ]
  }

}
