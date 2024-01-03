packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

variable "baseimage_name" {
  type = string
}

variable "build_id" {
  type = string
}

variable "cluster_or_esxi_host" {
  type = string
}

variable "esxi_datastore" {
  type = string
}

variable "github_api_pat" {
  type      = string
  default   = ""
  sensitive = true
}

variable "image_os" {
  type    = string
  default = "macos11"
}

variable "output_folder" {
  type = string
}

variable "vcenter_datacenter" {
  type = string
}

variable "vcenter_password" {
  type      = string
  sensitive = true
}

variable "vcenter_server" {
  type = string
}

variable "vcenter_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "xcode_install_sas" {
  type      = string
  sensitive = true
}

variable "xcode_install_storage_url" {
  type      = string
  sensitive = true
}

source "vsphere-clone" "template" {
  CPUs                = "5"
  NestedHV            = "true"
  RAM                 = "24576"
  cpu_cores           = "5"
  datacenter          = "${var.vcenter_datacenter}"
  datastore           = "${var.esxi_datastore}"
  folder              = "${var.output_folder}"
  host                = "${var.cluster_or_esxi_host}"
  insecure_connection = true
  password            = "${var.vcenter_password}"
  shutdown_timeout    = "15m"
  ssh_password        = "${var.vm_password}"
  ssh_username        = "${var.vm_username}"
  template            = "${var.baseimage_name}"
  username            = "${var.vcenter_username}"
  vcenter_server      = "${var.vcenter_server}"
  vm_name             = "${var.build_id}"
}

build {
  sources = ["source.vsphere-clone.template"]

  provisioner "shell" {
    inline = "mkdir ~/image-generation"
  }

  provisioner "file" {
    destination = "~/image-generation/"
    sources     = [
      "./assets/xamarin-selector",
      "./scripts/tests",
      "./scripts/docs-gen",
      "./scripts/helpers"
    ]
  }

  provisioner "file" {
    destination = "~/image-generation/docs-gen/"
    source      = "../../helpers/software-report-base"
  }

  provisioner "file" {
    destination = "~/image-generation/add-certificate.swift"
    source      = "./assets/add-certificate.swift"
  }

  provisioner "file" {
    destination = "~/.bashrc"
    source      = "./assets/bashrc"
  }

  provisioner "file" {
    destination = "~/.bash_profile"
    source      = "./assets/bashprofile"
  }

  provisioner "shell" {
    inline = [ "mkdir ~/image-generation" ]
  }

  provisioner "file" {
    destination = "~/bootstrap"
    source      = "./assets/bootstrap-provisioner"
  }

  provisioner "file" {
    destination = "~/image-generation/toolset.json"
    source      = "./toolsets/toolset-11.json"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mv ~/image-generation/docs-gen ~/image-generation/software-report",
      "mv ~/image-generation/xamarin-selector ~/image-generation/assets",
      "mkdir ~/utils",
      "mv ~/image-generation/helpers/confirm-identified-developers.scpt ~/utils",
      "mv ~/image-generation/helpers/invoke-tests.sh ~/utils",
      "mv ~/image-generation/helpers/utils.sh ~/utils",
      "mv ~/image-generation/helpers/xamarin-utils.sh ~/utils"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "./scripts/build/install-xcode-clt.sh",
      "./scripts/build/install-homebrew.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["PASSWORD=${var.vm_password}", "USERNAME=${var.vm_username}"]
    execute_command  = "chmod +x {{ .Path }}; sudo {{ .Vars }} {{ .Path }}"
    scripts          = [
      "./scripts/build/install-xcode-clt.sh",
      "./scripts/build/configure-network-interface-detection.sh",
      "./scripts/build/configure-autologin.sh",
      "./scripts/build/configure-auto-updates.sh",
      "./scripts/build/configure-screensaver.sh",
      "./scripts/build/configure-ntpconf.sh",
      "./scripts/build/configure-max-files-limitation.sh",
      "./scripts/build/configure-shell.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.build_id}", "IMAGE_OS=${var.image_os}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "./scripts/build/configure-preimagedata.sh",
      "./scripts/build/configure-ssh.sh",
      "./scripts/build/configure-machine.sh"
    ]
  }

  provisioner "shell" {
    execute_command   = "sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    pause_before     = "30s"
    scripts          = [
      "./scripts/build/configure-windows.sh",
      "./scripts/build/install-powershell.sh",
      "./scripts/build/install-dotnet.sh",
      "./scripts/build/install-python.sh",
      "./scripts/build/install-azcopy.sh",
      "./scripts/build/install-openssl.sh",
      "./scripts/build/install-ruby.sh",
      "./scripts/build/install-rubygems.sh",
      "./scripts/build/install-git.sh",
      "./scripts/build/install-mongodb.sh",
      "./scripts/build/install-node.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["XCODE_INSTALL_STORAGE_URL=${var.xcode_install_storage_url}", "XCODE_INSTALL_SAS=${var.xcode_install_sas}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} pwsh -f {{ .Path }}"
    script           = "./scripts/build/Install-Xcode.ps1"
  }

  provisioner "shell" {
    execute_command   = "sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "./scripts/build/install-actions-cache.sh",
      "./scripts/build/install-common-utils.sh",
      "./scripts/build/install-llvm.sh",
      "./scripts/build/install-golang.sh",
      "./scripts/build/install-swiftlint.sh",
      "./scripts/build/install-openjdk.sh",
      "./scripts/build/install-php.sh",
      "./scripts/build/install-aws-tools.sh",
      "./scripts/build/install-rust.sh",
      "./scripts/build/install-gcc.sh",
      "./scripts/build/install-haskell.sh",
      "./scripts/build/install-cocoapods.sh",
      "./scripts/build/install-android-sdk.sh",
      "./scripts/build/install-xamarin.sh",
      "./scripts/build/install-visualstudio.sh",
      "./scripts/build/install-nvm.sh",
      "./scripts/build/install-apache.sh",
      "./scripts/build/install-nginx.sh",
      "./scripts/build/install-postgresql.sh",
      "./scripts/build/install-audiodevice.sh",
      "./scripts/build/install-vcpkg.sh",
      "./scripts/build/install-miniconda.sh",
      "./scripts/build/install-safari.sh",
      "./scripts/build/install-chrome.sh",
      "./scripts/build/install-edge.sh",
      "./scripts/build/install-firefox.sh",
      "./scripts/build/install-pypy.sh",
      "./scripts/build/install-pipx-packages.sh",
      "./scripts/build/install-bicep.sh",
      "./scripts/build/install-codeql-bundle.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} pwsh -f {{ .Path }}"
    scripts         = [
      "./scripts/build/Install-Toolset.ps1",
      "./scripts/build/Configure-Toolset.ps1"
    ]
  }

  provisioner "shell" {
    execute_command = "ruby {{ .Path }}"
    script          = "./scripts/build/configure-xcode-simulators.rb"
  }

  provisioner "shell" {
    inline = [
      "pwsh -File \"$HOME/image-generation/software-report/Generate-SoftwareReport.ps1\" -OutputDirectory \"$HOME/image-generation/output/software-report\" -ImageName ${var.build_id}",
      "pwsh -File \"$HOME/image-generation/tests/RunAll-Tests.ps1\""
    ]
  }

  provisioner "file" {
    destination = "../image-output/"
    direction   = "download"
    source      = "~/image-generation/output/*"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "./scripts/build/configure-hostname.sh",
      "./scripts/build/configure-system.sh"
    ]
  }
}
