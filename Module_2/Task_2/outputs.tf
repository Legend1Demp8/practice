output "vm_info" {
  description = "Список параметров для каждой ВМ"
  value = [
    for vm in [yandex_compute_instance.platform, yandex_compute_instance.platform-a] : {
      instance_name = vm.name
      external_ip   = vm.network_interface[0].nat_ip_address
      fqdn          = vm.fqdn
    }
  ]
}
