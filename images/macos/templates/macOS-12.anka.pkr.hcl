packer {
  required_plugins {
    veertu-anka = {
      version = ">= v3.2.0"
      source = "github.com/veertuinc/veertu-anka"
    }
  }
}

variable "source_vm_name" {
  type = string
}

variable "source_vm_tag" {
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

variable "vcpu_count" {
  type = string
  default = "6"
}

variable "ram_size" {
  type = string
  default = "24G"
}

variable "image_os" {
  type = string
  default = "macos12"
}

source "veertu-anka-vm-clone" "template" {
  vm_name = "${var.build_id}"
  source_vm_name = "${var.source_vm_name}"
  source_vm_tag = "${var.source_vm_tag}"
  vcpu_count = "${var.vcpu_count}"
  ram_size = "${var.ram_size}"
  stop_vm = "true"
}

build {
  sources = [
    "source.veertu-anka-vm-clone.template"
  ]
  provisioner "shell" {
    inline = [
      "mkdir ~/image-generation"
    ]
  }
  provisioner "file" {
    destination = "image-generation/"
    sources = [
      "./assets/xamarin-selector",
      "./scripts/tests",
      "./scripts/docs-gen",
      "./scripts/helpers"
    ]
  }
  provisioner "file" {
    destination = "image-generation/docs-gen/"
    source = "../../helpers/software-report-base"
  }
  provisioner "file" {
    destination = "image-generation/add-certificate.swift"
    source = "./assets/add-certificate.swift"
  }
  provisioner "file" {
    destination = ".bashrc"
    source = "./asset/bashrc"
  }
  provisioner "file" {
    destination = ".bash_profile"
    source = "./asset/bashprofile"
  }
  provisioner "shell" {
    inline = [
      "mkdir ~/bootstrap"
    ]
  }
  provisioner "file" {
    destination = "bootstrap"
    source = "./assets/bootstrap-provisioner/"
  }
  provisioner "file" {
    destination = "image-generation/toolset.json"
    source = "./toolsets/toolset-12.json"
  }
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mv ~/image-generation/docs-gen ~/image-generation/software-report",
      "mv ~/image-generation/xamarin-selector ~/image-generation/assets",
      "mkdir ~/image-generation/utils",
      "mv ~/image-generation/helpers/confirm-identified-developers.scpt ~/image-generation/utils",
      "mv ~/image-generation/helpers/invoke-tests.sh ~/image-generation/utils",
      "mv ~/image-generation/helpers/utils.sh ~/image-generation/utils",
      "mv ~/image-generation/helpers/xamarin-utils.sh ~/image-generation/utils"
    ]
  }
  provisioner "shell" {
    scripts = [
      "./scripts/build/xcode-clt.sh",
      "./scripts/build/homebrew.sh"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./scripts/build/configure-tccdb-macos.sh",
      "./scripts/build/add-network-interface-detection.sh",
      "./scripts/build/autologin.sh",
      "./scripts/build/disable-auto-updates.sh",
      "./scripts/build/screensaver-off.sh",
      "./scripts/build/ntpconf.sh",
      "./scripts/build/max-files.sh",
      "./scripts/build/shell-change.sh"
    ]
    environment_vars = [
      "PASSWORD=${var.vm_password}",
      "USERNAME=${var.vm_username}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./scripts/build/preimagedata.sh",
      "./scripts/build/configure-ssh.sh",
      "./scripts/build/configure-machine.sh"
    ]
    environment_vars = [
      "IMAGE_VERSION=${var.build_id}",
      "IMAGE_OS=${var.image_os}",
      "PASSWORD=${var.vm_password}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script  = "./scripts/build/reboot.sh"
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    pause_before = "30s"
    scripts = [
      "./scripts/build/open_windows_check.sh",
      "./scripts/build/powershell.sh",
      "./scripts/build/dotnet.sh",
      "./scripts/build/python.sh",
      "./scripts/build/azcopy.sh",
      "./scripts/build/openssl.sh",
      "./scripts/build/ruby.sh",
      "./scripts/build/rubygem.sh",
      "./scripts/build/git.sh",
      "./scripts/build/mongodb.sh",
      "./scripts/build/node.sh",
      "./scripts/build/commonutils.sh"
    ]
    environment_vars = [
      "API_PAT=${var.github_api_pat}",
      "USER_PASSWORD=${var.vm_password}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script = "./scripts/build/xcode.ps1"
    environment_vars = [
      "XCODE_INSTALL_STORAGE_URL=${var.xcode_install_storage_url}",
      "XCODE_INSTALL_SAS=${var.xcode_install_sas}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./scripts/build/reboot.sh"
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    scripts = [
      "./scripts/build/action-archive-cache.sh",
      "./scripts/build/llvm.sh",
      "./scripts/build/golang.sh",
      "./scripts/build/swiftlint.sh",
      "./scripts/build/openjdk.sh",
      "./scripts/build/php.sh",
      "./scripts/build/aws.sh",
      "./scripts/build/rust.sh",
      "./scripts/build/gcc.sh",
      "./scripts/build/haskell.sh",
      "./scripts/build/cocoapods.sh",
      "./scripts/build/android-toolsets.sh",
      "./scripts/build/xamarin.sh",
      "./scripts/build/vsmac.sh",
      "./scripts/build/nvm.sh",
      "./scripts/build/apache.sh",
      "./scripts/build/nginx.sh",
      "./scripts/build/postgresql.sh",
      "./scripts/build/audiodevice.sh",
      "./scripts/build/vcpkg.sh",
      "./scripts/build/miniconda.sh",
      "./scripts/build/safari.sh",
      "./scripts/build/chrome.sh",
      "./scripts/build/edge.sh",
      "./scripts/build/firefox.sh",
      "./scripts/build/pypy.sh",
      "./scripts/build/pipx-packages.sh",
      "./scripts/build/bicep.sh",
      "./scripts/build/codeql-bundle.sh"
    ]
    environment_vars = [
      "API_PAT=${var.github_api_pat}"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./scripts/build/toolset.ps1",
      "./scripts/build/configure-toolset.ps1"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./scripts/build/delete-duplicate-sims.rb"
    execute_command = "source $HOME/.bash_profile; ruby {{ .Path }}"
  }
  provisioner "shell" {
      script = "./scripts/build/fix-xcode-simulators.ps1"
      execute_command = "chmod +x {{ .Path }}; {{ .Vars }} pwsh -f {{ .Path }}"
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
      "./scripts/build/configure-hostname.sh",
      "./scripts/build/finalize-vm.sh"
    ]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
}
