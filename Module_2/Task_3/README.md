## Задание 1
### Результат:
<img width="980" height="628" alt="image" src="https://github.com/user-attachments/assets/f3c7ee30-2a95-483e-bbb5-78ef3ffe1546" />

## Задание 2
<img width="1582" height="258" alt="image" src="https://github.com/user-attachments/assets/67e9dc3c-0d51-4bbc-9492-7178160c8f20" />
### Задача 1
Создайте файл count-vm.tf. Опишите в нём создание двух одинаковых ВМ web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )

### Решение
Формулировка не ограничивает исполнителя как либо в написании кода кроме явного требования использования count loop и использования уже созданной сети и секьюрити группы
Я написал все в одном файле [count-vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/count-vm.tf)

### Задача 2
Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" разных по cpu/ram/disk_volume , используя мета-аргумент for_each loop. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```

### Решение
