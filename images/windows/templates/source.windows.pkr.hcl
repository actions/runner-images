packer {
  required_plugins {
    docker = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "container" {
  build {
    path      = "${path.root}/Dockerfile"
    build_dir = path.root
    arguments = {
      BASE_IMAGE   = local.source_image
      INSTALL_USER = var.install_user
    }
  }
  exec_user         = "packer"
  platform          = endswith(var.image_os, "-arm64") ? "windows/arm64" : "windows/amd64"
  windows_container = true
  commit            = true
  changes           = ["USER ContainerAdministrator"]
}
