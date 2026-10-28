resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count = 2

  name = "web-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8bu5qanc4labigou11"
      size =  10
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXNEhyxwyfDYpw5Q7vz9FFPdy+BSa6OANyaPPlxlMhQ root@gw-spb"
  }
}
