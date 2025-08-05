// Authentication related variables
variable "client_cert_path" {
  type    = string
  default = "${env("ARM_CLIENT_CERT_PATH")}"
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
variable "object_id" {
  type    = string
  default = "${env("ARM_OBJECT_ID")}"
}
variable "oidc_request_token" {
  type    = string
  default = ""
}
variable "oidc_request_url" {
  type    = string
  default = ""
}
variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}
variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}
variable "use_azure_cli_auth" {
  type    = bool
  default = false
}

// Azure environment related variables
variable "allowed_inbound_ip_addresses" {
  type    = list(string)
  default = []
}
variable "azure_tags" {
  type    = map(string)
  default = {}
}
variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RG_NAME")}"
}
variable "gallery_image_name" {
  type    = string
  default = "${env("GALLERY_IMAGE_NAME")}"
}
variable "gallery_image_version" {
  type    = string
  default = "${env("GALLERY_IMAGE_VERSION")}"
}
variable "gallery_name" {
  type    = string
  default = "${env("GALLERY_NAME")}"
}
variable "gallery_resource_group_name" {
  type    = string
  default = "${env("GALLERY_RG_NAME")}"
}
variable "gallery_storage_account_type" {
  type    = string
  default = "${env("GALLERY_STORAGE_ACCOUNT_TYPE")}"
}
variable "image_os_type" {
  type    = string
  default = "Linux"
}
variable "location" {
  type    = string
  default = ""
}
variable "managed_image_name" {
  type    = string
  default = ""
}
variable "managed_image_resource_group_name" {
  type    = string
  default = "${env("ARM_RESOURCE_GROUP")}"
}
variable "managed_image_storage_account_type" {
  type    = string
  default = "Premium_LRS"
}
variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = false
}
variable "os_disk_size_gb" {
  type    = number
  default = null
}
variable "source_image_version" {
  type    = string
  default = "latest"
}
variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
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
variable "winrm_username" {         // The username used to connect to the VM via WinRM
    type    = string                // Also applies to the username used to create the VM
    default = "packer"
}

// Image related variables
variable "dockerhub_login" {
  type    = string
  default = "${env("DOCKERHUB_LOGIN")}"
}
variable "dockerhub_password" {
  type    = string
  default = "${env("DOCKERHUB_PASSWORD")}"
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
  default = ""
}
variable "image_version" {
  type    = string
  default = "dev"
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
  default   = ""
  sensitive = true
}
variable "install_user" {
  type    = string
  default = "installer"
}
