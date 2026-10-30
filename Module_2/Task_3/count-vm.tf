resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count = var.web_instance_count

  name = "web-${count.index + 1}"
  platform_id = var.web_instance_config.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.web_instance_config.cores
    memory        = var.web_instance_config.memory
    core_fraction = var.web_instance_config.core_fraction
  }

  scheduling_policy {
    preemptible = var.web_instance_config.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.web_instance_config.image_id
      size     = var.web_instance_config.disk_size
      type     = var.web_instance_config.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = var.web_instance_config.nat
  }

  metadata = {
    ssh-keys = local.ssh_key
  }
}
