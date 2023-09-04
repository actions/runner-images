packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.6"
    }
  }
}

variable "source_ami_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "build_id" {
  type = string
}

variable "vm_username" {
  type = string
  sensitive = true
}

variable "vm_password" {
  type = string
  sensitive = true
}

variable "ssh_keypair_name" {
  type = string
}

variable "ssh_private_key_file" {
  type = string
}

variable "github_api_pat" {
  type = string
  default = ""
}

variable "xcode_install_storage_url" {
  type = string
  sensitive = true
}

variable "xcode_install_sas" {
  type = string
  sensitive = true
}

variable "image_os" {
  type = string
  default = "macos13"
}

data "amazon-ami" "macos-base-image" {
  filters = {
    name                = "${var.source_ami_name}"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
}

source "amazon-ebs" "template" {
  ami_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 380
    volume_type           = "gp3"
  }
  ami_description             = "Packer build: ${var.build_id}"
  ami_name                    = "${var.build_id}-{{timestamp}}"
  ami_virtualization_type     = "hvm"
  associate_public_ip_address = true
  instance_type               = "${var.instance_type}"
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 380
    volume_type           = "gp3"
  }
  placement {
    tenancy = "host"
  }
  source_ami           = "${data.amazon-ami.macos-base-image.id}"
  ssh_keypair_name     = "${var.ssh_keypair_name}"
  ssh_private_key_file = "${var.ssh_private_key_file}"
  ssh_timeout          = "2h"
  ssh_username         = "${var.vm_username}"
}

build {
  sources = [
    "source.amazon-ebs.template"
  ]
  provisioner "shell" {
    inline = [
      "mkdir ~/image-generation"
    ]
  }
  provisioner "file" {
    destination = "image-generation/"
    sources = [
      "./provision/assets",
      "./tests",
      "./software-report",
      "./helpers"
    ]
  }
  provisioner "file" {
    destination = "image-generation/software-report/"
    source = "../../helpers/software-report-base"
  }
  provisioner "file" {
    destination = "image-generation/add-certificate.swift"
    source = "./provision/configuration/add-certificate.swift"
  }
  provisioner "file" {
    destination = ".bashrc"
    source = "./provision/configuration/environment/bashrc"
  }
  provisioner "file" {
    destination = ".bash_profile"
    source = "./provision/configuration/environment/bashprofile"
  }
  provisioner "file" {
    destination = "./"
    source = "./provision/utils"
  }
  provisioner "shell" {
    inline = [
      "mkdir ~/bootstrap"
    ]
  }
  provisioner "file" {
    destination = "bootstrap"
    source = "./provision/bootstrap-provisioner/"
  }
  provisioner "file" {
    destination = "image-generation/toolset.json"
    source = "./toolsets/toolset-13.json"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/aws.sh"
    ]
    environment_vars = [
      "PASSWORD=${var.vm_password}",
      "USERNAME=${var.vm_username}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./provision/core/xcode-clt.sh",
      "./provision/core/homebrew.sh",
      "./provision/core/rosetta.sh"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      //"./provision/configuration/configure-tccdb-macos.sh",
      "./provision/configuration/disable-auto-updates.sh",
      "./provision/configuration/ntpconf.sh",
      "./provision/configuration/shell-change.sh"
    ]
    environment_vars = [
      "PASSWORD=${var.vm_password}",
      "USERNAME=${var.vm_username}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/preimagedata.sh",
      "./provision/configuration/configure-ssh.sh",
      "./provision/configuration/configure-machine.sh"
    ]
    environment_vars = [
      "IMAGE_VERSION=${var.build_id}",
      "IMAGE_OS=${var.image_os}",
      "PASSWORD=${var.vm_password}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script  = "./provision/core/reboot.sh"
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    pause_before = "30s"
    scripts = [
      "./provision/core/powershell.sh",
      "./provision/core/dotnet.sh",
      "./provision/core/azcopy.sh",
      "./provision/core/ruby.sh",
      "./provision/core/rubygem.sh",
      "./provision/core/git.sh",
      "./provision/core/node.sh",
      "./provision/core/commonutils.sh"
    ]
    environment_vars = [
      "API_PAT=${var.github_api_pat}",
      "USER_PASSWORD=${var.vm_password}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/xcode.ps1"
    environment_vars = [
      "XCODE_INSTALL_STORAGE_URL=${var.xcode_install_storage_url}",
      "XCODE_INSTALL_SAS=${var.xcode_install_sas}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/reboot.sh"
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    scripts = [
      "./provision/core/llvm.sh",
      "./provision/core/rust.sh",
      "./provision/core/gcc.sh",
      "./provision/core/cocoapods.sh",
      "./provision/core/safari.sh",
      "./provision/core/bicep.sh",
      "./provision/core/codeql-bundle.sh"
    ]
    environment_vars = [
      "API_PAT=${var.github_api_pat}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./provision/core/toolset.ps1",
      "./provision/core/configure-toolset.ps1"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/delete-duplicate-sims.rb"
    execute_command = "source $HOME/.bash_profile; ruby {{ .Path }}"
  }
  provisioner "shell" {
    inline = [
      "pwsh -File \"$HOME/image-generation/software-report/SoftwareReport.Generator.ps1\" -OutputDirectory \"$HOME/image-generation/output/software-report\" -ImageName ${var.build_id}",
      "pwsh -File \"$HOME/image-generation/tests/RunAll-Tests.ps1\""
    ]
    execute_command = "source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "file" {
    destination = "../image-output/"
    direction = "download"
    source = "./image-generation/output/"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/configure-hostname.sh",
      "./provision/configuration/finalize-vm-aws.sh"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
}
