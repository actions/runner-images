// Image related variables
variable "agent_tools_directory" {
  type    = string
  default = "C:\\hostedtoolcache\\windows"
}
variable "helper_script_folder" {
  type    = string
  default = "C:\\Program Files\\WindowsPowerShell\\Modules\\"
}
variable "image_folder" {
  type    = string
  default = "C:\\image"
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
  default = "C:\\imagedata.json"
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
variable "temp_dir" {
  type    = string
  default = "D:\\temp"
}
