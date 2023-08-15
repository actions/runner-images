variable "allowed_inbound_ip_addresses" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "azure_tag" {
  type    = map(string)
   default = {
    environment = "production",
    assetname   = "devops-shared-vmss-linux",
    assetNr     = "APPAIDO-238",
    tool        = "terraform"
  }
}

variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RESOURCE_GROUP_NAME")}"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type      = string
  default   = "${env("ARM_CLIENT_SECRET")}"
  sensitive = true
}

variable "helper_script_folder" {
  type    = string
  default = "/imagegeneration/helpers"
}

variable "image_folder" {
  type    = string
  default = "/imagegeneration"
}

variable "image_os" {
  type    = string
  default = "ubuntu22"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "imagedata_file" {
  type    = string
  default = "/imagegeneration/imagedata.json"
}

variable "installer_script_folder" {
  type    = string
  default = "/imagegeneration/installers"
}

variable "install_password" {
  type      = string
  sensitive = true
}

variable "location" {
  type    = string
  default = "${env("ARM_RESOURCE_LOCATION")}"
}

variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = true
}

variable "object_id" {
  type    = string
  default = "${env("ARM_OBJECT_ID")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "virtual_network_name" {
  type    = string
  default = "${env("VNET_NAME")}"
}

variable "virtual_network_resource_group_name" {
  type    = string
  default = "${env("VNET_RESOURCE_GROUP")}"
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "${env("VNET_SUBNET")}"
}

variable "vm_size" {
  type    = string
  default = "Standard_D4s_v4"
}

variable "managed_image_name" {
  type    = string
  default = "${env("managed_image_name")}"
}

variable "managed_image_resource_group_name" {
  type    = string
  default = "${env("managed_image_resource_group_name")}"
}

variable "gallery_resource_group" {
  type    = string
  default = "${env("gallery_resource_group")}"
}

variable "gallery_name" {
  type    = string
  default = "${env("gallery_name")}"
}

variable "gallery_source_image_name" {
  type    = string
  default = "${env("gallery_source_image_name")}"
}

variable "gallery_source_image_version" {
  type    = string
  default = "${env("gallery_source_image_version")}"
}

variable "gallery_dest_image_name" {
  type    = string
  default = "${env("gallery_dest_image_name")}"
}

variable "gallery_dest_image_version" {
  type    = string
  default = "${env("gallery_dest_image_version")}"
}

variable "github_feed_token" {
  type    = string
  default = "${env("github_feed_token")}"
}

source "azure-arm" "build_vhd" {
  allowed_inbound_ip_addresses           = "${var.allowed_inbound_ip_addresses}"
  build_resource_group_name              = "${var.build_resource_group_name}"
  client_id                              = "${var.client_id}"
  client_secret                          = "${var.client_secret}"
  communicator                           = "ssh"
  location                               = "${var.location}"
  managed_image_name                     = "${var.managed_image_name}"
  managed_image_resource_group_name      = "${var.managed_image_resource_group_name}"
  object_id                              = "${var.object_id}"   
  os_disk_size_gb                        = "200"
  os_type                                = "Linux"
  private_virtual_network_with_public_ip = "${var.private_virtual_network_with_public_ip}"
  shared_image_gallery {
    gallery_name   = "${var.gallery_name}"
    image_name     = "${var.gallery_source_image_name}"
    image_version  = "${var.gallery_source_image_version}"
    resource_group = "${var.gallery_resource_group}"
    subscription   = "${var.subscription_id}"
  }
  shared_image_gallery_destination {
    gallery_name        = "${var.gallery_name}"
    image_name          = "${var.gallery_dest_image_name}"
    image_version       = "${var.gallery_dest_image_version}"
    replication_regions = ["${var.location}"]
    resource_group      = "${var.gallery_resource_group}"
    subscription        = "${var.subscription_id}"
  }
  subscription_id                     = "${var.subscription_id}"
  temp_resource_group_name            = "${var.temp_resource_group_name}"
  tenant_id                           = "${var.tenant_id}"
  virtual_network_name                = "${var.virtual_network_name}"
  virtual_network_resource_group_name = "${var.virtual_network_resource_group_name}"
  virtual_network_subnet_name         = "${var.virtual_network_subnet_name}"
  vm_size                             = "${var.vm_size}"
  
  dynamic "azure_tag" {
    for_each = var.azure_tag
    content {
      name  = azure_tag.key
      value = azure_tag.value
    }
  }
}

build {
  sources = ["source.azure-arm.build_vhd"]

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["apt-get install -y sshpass", "wget https://downloads.mongodb.com/compass/mongodb-mongosh_1.8.0_amd64.deb", "apt-get install ./mongodb-mongosh_1.8.0_amd64.deb", "wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.7.0.deb", "apt-get install ./mongodb-database-tools-ubuntu2204-x86_64-100.7.0.deb"]
  }
}
