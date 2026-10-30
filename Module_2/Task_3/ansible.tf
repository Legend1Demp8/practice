resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible.tftpl", {
    groups = {
      webservers = {
        for vm in yandex_compute_instance.web : vm.name => {
          ip   = vm.network_interface[0].nat_ip_address
          fqdn = vm.fqdn
        }
      }

      databases = {
        for k, vm in yandex_compute_instance.db : vm.name => {
          ip   = vm.network_interface[0].nat_ip_address
          fqdn = vm.fqdn
        }
      }

      storage = {
        for vm in [yandex_compute_instance.storage] : vm.name => {
          ip   = vm.network_interface[0].nat_ip_address
          fqdn = vm.fqdn
        }
      }
    }
  })

  filename = "${path.module}/inventory.ini"
}
