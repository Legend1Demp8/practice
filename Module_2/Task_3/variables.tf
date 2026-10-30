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


variable "storage_disk_config" {
  type = object({
    count = number
    size  = number
    type  = string
  })
  default = {
    count = 3
    size  = 1
    type  = "network-hdd"
  }
  description = "Конфигурация дополнительных дисков для storage"
}

variable "storage_instance_config" {
  type = object({
    platform_id   = string
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string
    disk_size     = number
    disk_type     = string
    preemptible   = bool
    nat           = bool
  })
  default = {
    platform_id   = "standard-v2"
    cores         = 2
    memory        = 2
    core_fraction = 5
    image_id      = "fd8bu5qanc4labigou11"
    disk_size     = 10
    disk_type     = "network-hdd"
    preemptible   = true
    nat           = true
  }
  description = "Конфигурация ресурсов и загрузочного диска для storage ВМ"
}

variable "web_instance_count" {
  type        = number
  default     = 2
  description = "Количество ВМ для web"
}

variable "web_instance_config" {
  type = object({
    platform_id   = string
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string
    disk_size     = number
    disk_type     = string
    preemptible   = bool
    nat           = bool
  })
  default = {
    platform_id   = "standard-v2"
    cores         = 2
    memory        = 2
    core_fraction = 5
    image_id      = "fd8bu5qanc4labigou11"
    disk_size     = 10
    disk_type     = "network-hdd"
    preemptible   = true
    nat           = true
  }
}
