###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    core_fraction = number
    preemptible = bool
    disk_volume = number
    disk_type = string
    image_id = string
    platform_id = string
  }))
  default = [
    { vm_name = "main",    cpu = 2, ram = 2, core_fraction = 5, preemptible = true, disk_volume = 10, disk_type = "network-ssd", image_id = "fd8bu5qanc4labigou11", platform_id = "standard-v2"},
    { vm_name = "replica", cpu = 4, ram = 4, core_fraction = 5, preemptible = true, disk_volume = 10, disk_type = "network-hdd", image_id = "fd8bu5qanc4labigou11", platform_id = "standard-v2"}
  ]
}
