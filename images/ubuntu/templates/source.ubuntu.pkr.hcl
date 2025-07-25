local "aws_ami_name_x86_64" {
  expression = "GitHub Actions Runner Ubuntu 22.04 ${formatdate("YYYY-MM-DD hh.mm ZZZ", timestamp())} x86_64"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "build_image" {
  ami_name = local.aws_ami_name_x86_64

  ami_users = [
    "702719119055",
  ]

  subnet_filter {
    filters = {
      "tag:Environment" : "github-actions-runners"
      "tag:Name" : "*-public-*"
    }
    random = true
  }

  associate_public_ip_address = true

  ssh_interface = "public_ip"

  spot_instance_types = [
    "c7a.xlarge",
  ]

  spot_price = "auto"

  region = "us-east-2"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ubuntu"

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_type           = "gp3"
    volume_size           = 120
    delete_on_termination = true
  }
}
