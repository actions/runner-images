packer {
  required_plugins {
    docker = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/docker"
    }
    lxd = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/lxd"
    }
  }
}

source "lxd" "container" {
  image        = local.source_image
  output_image = var.image_os

  launch_config = {
    "security.nesting" = "true"
  }

  publish_properties = {
    description = "GitHub Actions runner image ${var.image_os} ${var.image_version}"
  }
}

source "lxd" "vm" {
  image           = local.source_image
  output_image    = "${var.image_os}-vm"
  virtual_machine = true

  publish_properties = {
    description = "GitHub Actions runner image ${var.image_os} ${var.image_version}"
  }
}
