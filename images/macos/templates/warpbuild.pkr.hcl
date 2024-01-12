packer {
  required_plugins {
    tart = {
      version = ">= 1.2.0"
      source  = "github.com/cirruslabs/tart"
    }
  }
}

variable "vm_name" {
  type = string
}

variable "vm_username" {
  type = string
  default = "runner"
  sensitive = true
}

variable "vm_password" {
  type = string
  default = "runner"
  sensitive = true
}

variable "github_api_pat" {
  type = string
  default = ""
}

variable "vcpu_count" {
  type = number
  default = 6
}

variable "ram_size" {
  type = number
  default = 8
}

variable "image_os" {
  type = string
  default = "macos13"
}

source "tart-cli" "tart" {
  vm_name      = "${var.vm_name}"
  cpu_count    = var.vcpu_count
  memory_gb    = var.ram_size
  disk_size_gb = 200
  headless     = true
  ssh_password = var.vm_password
  ssh_username = var.vm_username
  ssh_timeout  = "120s"
}

build {
  sources = [
    "source.tart-cli.tart"
  ]

  provisioner "shell" {
    scripts = [
      "./scripts/warpbuild/install-agent.sh",
      "./scripts/warpbuild/install-github-runner.sh"
    ]
  }

}
 