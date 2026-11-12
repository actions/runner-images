locals {
  image_properties_map = {
      "ubuntu22" = {
            source_image_marketplace_sku = "canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2"
            # x64 Ubuntu images run with very little headroom above the `Disk free space`
            # baseline test's 17 GB minimum (observed: 18 GB free on a cache-free main build,
            # i.e. only ~1 GB of margin). Bumped from 75 to 100 GB so the common dev/test
            # container image cache (docs/common-dev-container-images.md), including the large
            # espressif/idf image, fits with a safe margin. arm64 variants have more baseline
            # headroom and only need a smaller bump (see the "-arm64" entries below).
            os_disk_size_gb = 100
      },
      "ubuntu22-arm64" = {
            source_image_marketplace_sku = "canonical:0001-com-ubuntu-server-jammy:22_04-lts-arm64"
            # Bumped from 75 to 85 GB: arm64 has more baseline headroom than x64, but caching
            # espressif/idf (the largest of the common dev/test container images) still measured
            # as little as 16 GB free on Ubuntu 26.04 arm64 against the 17 GB minimum, so a modest
            # increase keeps a safe margin across all three arm64 versions.
            os_disk_size_gb = 85
      },
      "ubuntu24" = {
            source_image_marketplace_sku = "canonical:ubuntu-24_04-lts:server"
            os_disk_size_gb = 100
      },
      "ubuntu24-arm64" = {
            source_image_marketplace_sku = "canonical:ubuntu-24_04-lts:server-arm64"
            os_disk_size_gb = 85
      },
      "ubuntu26" = {
            source_image_marketplace_sku = "canonical:ubuntu-26_04-lts:server"
            os_disk_size_gb = 100
      },
      "ubuntu26-arm64" = {
            source_image_marketplace_sku = "canonical:ubuntu-26_04-lts:server-arm64"
            os_disk_size_gb = 85
      }
  }

  source_image_marketplace_sku = local.image_properties_map[var.image_os].source_image_marketplace_sku
  os_disk_size_gb = coalesce(var.os_disk_size_gb, local.image_properties_map[var.image_os].os_disk_size_gb)
}
