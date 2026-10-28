resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible.tftpl", {
    groups = {
      # Группа 1: web
      web = {
        for vm in yandex_compute_instance.web : vm.name => {
          ip   = vm.network_interface[0].nat_ip_address
          fqdn = vm.fqdn
        }
      }

      # Группа 2: db
      db = {
        for k, vm in yandex_compute_instance.db : vm.name => {
          ip   = vm.network_interface[0].nat_ip_address
          fqdn = vm.fqdn
        }
      }

      # Группа 3: storage
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
