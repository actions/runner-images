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

variable "from_ipsw" {
  type = string
  # You can find macOS IPSW URLs on various websites like https://ipsw.me/
  # and https://www.theiphonewiki.com/wiki/Beta_Firmware/Mac/13.x
  default = "https://updates.cdn-apple.com/2023SummerFCS/fullrestores/042-43686/945D434B-DA5D-48DB-A558-F6D18D11AD69/UniversalMac_13.5.2_22G91_Restore.ipsw"
}

source "tart-cli" "tart" {
  from_ipsw    = var.from_ipsw
  vm_name      = var.vm_name
  cpu_count    = var.vcpu_count
  memory_gb    = var.ram_size
  disk_size_gb = 40
  ssh_password = var.vm_password
  ssh_username = var.vm_username
  ssh_timeout  = "120s"
  boot_command = [
    # hello, hola, bonjour, etc.
    "<wait60s><spacebar>",
    # Language
    "<wait30s>english<enter>",
    # Select Your Country and Region
    "<wait30s>united states<leftShiftOn><tab><leftShiftOff><spacebar>",
    # Written and Spoken Languages
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Accessibility
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Data & Privacy
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Migration Assistant
    "<wait10s><tab><tab><tab><spacebar>",
    # Sign In with Your Apple ID
    "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Are you sure you want to skip signing in with an Apple ID?
    "<wait10s><tab><spacebar>",
    # Terms and Conditions
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # I have read and agree to the macOS Software License Agreement
    "<wait10s><tab><spacebar>",
    # Create a Computer Account
    "<wait10s>${var.vm_username}<tab><tab>${var.vm_password}<tab>${var.vm_password}<tab><tab><tab><spacebar>",
    # Enable Location Services
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Are you sure you don't want to use Location Services?
    "<wait10s><tab><spacebar>",
    # Select Your Time Zone
    "<wait10s><tab>UTC<enter><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Analytics
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Screen Time
    "<wait10s><tab><spacebar>",
    # Siri
    "<wait10s><tab><spacebar><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Choose Your Look
    "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Enable Voice Over
    "<wait10s><leftAltOn><f5><leftAltOff><wait5s>v",
    # Now that the installation is done, open "System Settings"
    "<wait10s><leftAltOn><spacebar><leftAltOff>System Settings<enter>",
    # Navigate to "Sharing"
    "<wait10s><leftAltOn>f<leftAltOff>sharing<enter>",
    # Navigate to "Screen Sharing" and enable it
    "<wait10s><tab><down><spacebar>",
    # Navigate to "Remote Login" and enable it
    "<wait10s><tab><tab><tab><tab><tab><tab><spacebar>",
    # Open "Remote Login" details
    "<wait10s><tab><spacebar>",
    # Enable "Full Disk Access"
    "<wait10s><tab><spacebar>",
    # Click "Done"
    "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><spacebar>",
    # Disable Voice Over
    "<leftAltOn><f5><leftAltOff>",
  ]

  // A (hopefully) temporary workaround for Virtualization.Framework's
  // installation process not fully finishing in a timely manner
  create_grace_time = "30s"
}

build {
  sources = ["source.tart-cli.tart"]

  provisioner "shell" {
    environment_vars = [
      "PASSWORD=${var.vm_password}"
    ]
    scripts = [
      "./scripts/prepare/setup-system.sh"
    ]
    # inline = [
    #   // Enable passwordless sudo
    #   "echo ${var.vm_password} | sudo -S sh -c \"mkdir -p /etc/sudoers.d/; echo '${var.vm_username} ALL=(ALL) NOPASSWD: ALL' | EDITOR=tee visudo /etc/sudoers.d/${var.vm_username}-nopasswd\"",
    #   // Enable auto-login
    #   //
    #   // See https://github.com/xfreebird/kcpassword for details.
    #   "echo '00000000: 1ced 3f4a bcbc ba2c caca 4e82' | sudo xxd -r - /etc/kcpassword",
    #   "sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser ${var.vm_username}",
    #   // Disable screensaver at login screen
    #   "sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime 0",
    #   // Disable screensaver for admin user
    #   "defaults -currentHost write com.apple.screensaver idleTime 0",
    #   // Prevent the VM from sleeping
    #   "sudo systemsetup -setdisplaysleep Off 2>/dev/null",
    #   "sudo systemsetup -setsleep Off 2>/dev/null",
    #   "sudo systemsetup -setcomputersleep Off 2>/dev/null",
    #   // Launch Safari to populate the defaults
    #   "/Applications/Safari.app/Contents/MacOS/Safari &",
    #   "SAFARI_PID=$!",
    #   "disown",
    #   "sleep 30",
    #   "kill -9 $SAFARI_PID",
    #   // Enable Safari's remote automation and "Develop" menu
    #   "sudo safaridriver --enable",
    #   "defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true",
    #   "defaults write com.apple.Safari IncludeDevelopMenu -bool true",
    #   // Disable screen lock
    #   //
    #   // Note that this only works if the user is logged-in,
    #   // i.e. not on login screen.
    #   "sysadminctl -screenLock off -password ${var.vm_password}",
    #   "defaults -currentHost write com.apple.screensaver idleTime 0"
    # ]
  }
}
