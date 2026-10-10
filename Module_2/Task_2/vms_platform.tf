###image vars
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Defaul image family"
}

###vm vars
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Default vm name"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v2"
  description = "Default vm name"
}

variable "vm_web_cores" {
  type    = number
  default = 2
  description = "Default vCPU core count"
}

variable "vm_web_memory" {
  type    = number
  default = 1
  description = "Default RAM value"
}

variable "vm_web_core_fraction" {
  type    = number
  default = 5
  description = "Default vCPU value"
}

###scheduling policy
variable "vm_web_preemptible" {
  type    = bool
  default = true
}

###network interface
variable "vm_web_nat" {
  type    = bool
  default = true
}


###vm vars
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Default vm name"
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v2"
  description = "Default vm name"
}

variable "vm_db_cores" {
  type    = number
  default = 2
  description = "Default vCPU core count"
}

variable "vm_db_memory" {
  type    = number
  default = 2
  description = "Default RAM value"
}

variable "vm_db_core_fraction" {
  type    = number
  default = 20
  description = "Default vCPU value"
}

###scheduling policy
variable "vm_db_preemptible" {
  type    = bool
  default = true
}

###network interface
variable "vm_db_nat" {
  type    = bool
  default = true
}





variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys           = string
  }))
  default = {
    common = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXNEhyzbsfDYpw5Q7vz9FFPdy+BSa6OANyaPPlxlMhQ root@gw-spb"
    }
  }
}
