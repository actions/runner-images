source "amazon-ebs" "image" {
#  ami_description             = var.ami_description
#  vpc_id                      = var.vpc_id
#  subnet_id                   = var.subnet_id
#  associate_public_ip_address = var.associate_public_ip_address
#  tags                        = var.aws_tags
  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size           = 75
    delete_on_termination = true
  }

  aws_polling {
    delay_seconds = 40
    max_attempts  = 5
  }

  ami_name      = "gh-runner-ubuntu-latest-aws-2"
  instance_type = "t2.large"
  region        = "us-east-1"
  ssh_username = "ubuntu"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # Canonical's AWS account ID
  }

  run_tags = {
    environment = "sandbox"
    product = "github-selfhosted-runners"
    scheduled = "na"
    contact = "rneumann@rccl.com"
    project = "github-selfhosted-runners"
    invoice = "na"
    brand = "both"
    Name = "github-selfhosted-runners-2"
  }
  tags = {
    environment = "sandbox"
    product = "github-selfhosted-runners"
    scheduled = "na"
    contact = "rneumann@rccl.com"
    project = "github-selfhosted-runners"
    invoice = "na"
    brand = "both"
    Name = "github-selfhosted-runners-2"
  }
 }
