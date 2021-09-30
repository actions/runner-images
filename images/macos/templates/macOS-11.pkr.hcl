variable "source_vm_name" {
  type = string 
  default = "clean_macos_11_300gb"
}

variable "source_vm_tag" {
  type = string
  default = "bigsur_300gb"
}

variable "vm_name" {
  type = string
  default = "macos-11"
}

variable "vcpu_count" {
  type = string
  default = "4"
}

variable "ram_size" {
  type = string
  default = "6G"
}

variable "image_os" {
  type = string
  default = "macos11"
}

variable "build_id" { type = string }
variable "vm_username" { type = string }
variable "vm_password" { type = string }
variable "xcode_install_user" { type = string }
variable "xcode_install_password" { type = string }

source "veertu-anka-vm-clone" "template" {
  vm_name = "${var.vm_name}"
  source_vm_name = "${var.source_vm_name}"
  source_vm_tag = "${var.source_vm_tag}"
  vcpu_count = "${var.vcpu_count}"
  ram_size = "${var.ram_size}"
  stop_vm =  "true"
}

build {  
  sources = [        
    "source.veertu-anka-vm-clone.template",
  ]
  provisioner "shell" {
    inline = [
      "mkdir ~/image-generation"
    ]
  }
  provisioner "file" {
    destination = "image-generation/"
    sources     = [ "./provision/assets", "./tests", "./software-report", "./helpers" ]
  }
  provisioner "file" {
    destination = "image-generation/add-certificate.swift"
    source      = "./provision/configuration/add-certificate.swift"
  }
  provisioner "file" {
    destination = ".bashrc"
    source      = "./provision/configuration/environment/bashrc"
  }
  provisioner "file" {
    destination = ".bash_profile"
    source      = "./provision/configuration/environment/bashprofile"
  }
  provisioner "file" {
    destination = "./"
    source      = "./provision/utils"
  }
  provisioner "shell" {
    inline = [
      "mkdir ~/bootstrap"
    ]
  }
  provisioner "file" {
    destination = "bootstrap"
    source      = "./provision/bootstrap-provisioner/"
  }
  provisioner "file" {
    destination = "image-generation/toolset.json"
    source      = "./toolsets/toolset-11.json"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/configure-tccdb-macos11.sh",
      "./provision/configuration/add-network-interface-detection.sh",
      "./provision/configuration/autologin.sh",
      "./provision/configuration/disable-auto-updates.sh",
      "./provision/configuration/screensaver-off.sh",
      "./provision/configuration/ntpconf.sh",
      "./provision/configuration/max-files.sh",
      "./provision/configuration/shell-change.sh"
    ]
    environment_vars = [
      "PASSWORD=${var.vm_password}",
      "USERNAME=${var.vm_username}"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/preimagedata.sh",
      "./provision/configuration/configure-ssh.sh",
      "./provision/core/xcode-clt.sh",
      "./provision/configuration/configure-machine.sh"
    ]
    environment_vars = [
      "IMAGE_VERSION=${var.build_id}",
      "IMAGE_OS=${var.image_os}"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/reboot.sh"
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    pause_before = "30s"
    scripts = [
      "./provision/core/homebrew.sh",
      "./provision/core/powershell.sh",
      "./provision/core/dotnet.sh",
      "./provision/core/python.sh",
      "./provision/core/azcopy.sh",
      "./provision/core/openssl.sh",
      "./provision/core/ruby.sh",
      "./provision/core/rubygem.sh",
      "./provision/core/git.sh",
      "./provision/core/node.sh"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/xcode.ps1"
    environment_vars = [
      "XCODE_INSTALL_USER=${var.xcode_install_user}",
      "XCODE_INSTALL_PASSWORD=${var.xcode_install_password}"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/reboot.sh"
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
  }
  provisioner "shell" {
    scripts = [
                "./provision/core/commonutils.sh",
                "./provision/core/golang.sh",
                "./provision/core/swiftlint.sh",
                "./provision/core/openjdk.sh",
                "./provision/core/php.sh",
                "./provision/core/aws.sh",
                "./provision/core/rust.sh",
                "./provision/core/gcc.sh",
                "./provision/core/haskell.sh",
                "./provision/core/stack.sh",
                "./provision/core/cocoapods.sh",
                "./provision/core/android-toolsets.sh",
                "./provision/core/xamarin.sh",
                "./provision/core/vsmac.sh",
                "./provision/core/nvm.sh",
                "./provision/core/apache.sh",
                "./provision/core/nginx.sh",
                "./provision/core/postgresql.sh",
                "./provision/core/mongodb.sh",
                "./provision/core/audiodevice.sh",
                "./provision/core/vcpkg.sh",
                "./provision/core/miniconda.sh",
                "./provision/core/safari.sh",
                "./provision/core/chrome.sh",
                "./provision/core/edge.sh",
                "./provision/core/firefox.sh",
                "./provision/core/pypy.sh",
                "./provision/core/pipx-packages.sh",
                "./provision/core/bicep.sh"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/toolset.ps1"
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
  }
  provisioner "shell" {
    script = "./provision/core/delete-duplicate-sims.rb"
    execute_command  = "source $HOME/.bash_profile; ruby {{ .Path }}"
  }
  provisioner "shell" {
    inline = [
      "pwsh -File \"$HOME/image-generation/software-report/SoftwareReport.Generator.ps1\" -OutputDirectory \"$HOME/image-generation/output/software-report\" -ImageName UUID=${build.PackerRunUUID}",
      "pwsh -File \"$HOME/image-generation/tests/RunAll-Tests.ps1\""
    ]
    execute_command  = "source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
  provisioner "file" {
    destination = "../image-output/"
    direction = "download"
    source      = "./image-generation/output/"
  }
  provisioner "shell" {
    scripts = [
      "./provision/configuration/configure-hostname.sh",
      "./provision/configuration/finalize-vm.sh"
    ]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
  }
}