locals {
  source_image_map = {
    "win22"              = "mcr.microsoft.com/windows/servercore:ltsc2022"
    "win25"              = "mcr.microsoft.com/windows/servercore:ltsc2025"
    "win25-vs2026"       = "mcr.microsoft.com/windows/servercore:ltsc2025"
    "win11-arm64"        = "mcr.microsoft.com/windows/servercore:ltsc2025"
    "win11-vs2026-arm64" = "mcr.microsoft.com/windows/servercore:ltsc2025"
  }

  source_image = local.source_image_map[var.image_os]
}
