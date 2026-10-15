locals {
  source_image_map = {
    "ubuntu22"       = "ubuntu:22.04"
    "ubuntu22-arm64" = "ubuntu:22.04"
    "ubuntu24"       = "ubuntu:24.04"
    "ubuntu24-arm64" = "ubuntu:24.04"
    "ubuntu26"       = "ubuntu:26.04"
    "ubuntu26-arm64" = "ubuntu:26.04"
  }

  source_image = local.source_image_map[var.image_os]
}
