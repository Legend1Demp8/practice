resource "yandex_compute_disk" "disk" {
  count = var.storage_disk_config.count
  name  = "disk-${count.index + 1}"
  size  = var.storage_disk_config.size
  type  = var.storage_disk_config.type
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.storage_instance_config.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.storage_instance_config.cores
    memory        = var.storage_instance_config.memory
    core_fraction = var.storage_instance_config.core_fraction
  }

  scheduling_policy {
    preemptible = var.storage_instance_config.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.storage_instance_config.image_id
      type     = var.storage_instance_config.disk_type
      size     = var.storage_instance_config.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = var.storage_instance_config.nat
  }

  metadata = {
    ssh-keys = local.ssh_key
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk[*].id
    content {
      disk_id = secondary_disk.value
    }
  }
}
