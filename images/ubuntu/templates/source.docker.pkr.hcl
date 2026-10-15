source "docker" "container" {
  image  = local.source_image
  commit = true
}
