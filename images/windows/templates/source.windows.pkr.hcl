packer {
  required_plugins {
    docker = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "container" {
  image             = local.source_image
  platform          = endswith(var.image_os, "-arm64") ? "windows/arm64" : "windows/amd64"
  windows_container = true
  commit            = true
}
