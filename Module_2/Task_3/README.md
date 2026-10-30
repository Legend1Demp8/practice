## Доработка
## 1) Группы инвентаря должны называться webservers, databases и storage, а у вас web и db;
### Решение 
Изменен Файл [ansible.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/ansible.tf) \
<img width="640" height="158" alt="image" src="https://github.com/user-attachments/assets/3fe1b80c-af0d-4c8a-b040-52801555e20c" />
## 2) Код нужно закоммитить в ветку terraform-03 и прислать ссылку на коммит.
[github](https://github.com/Legend1Demp8/terraform-03/tree/terraform-03)

---


## Задание 1
### Результат:
<img width="980" height="628" alt="image" src="https://github.com/user-attachments/assets/f3c7ee30-2a95-483e-bbb5-78ef3ffe1546" />

## Задание 2
### Подзадача 1
1. Создайте файл count-vm.tf. Опишите в нём создание двух одинаковых ВМ web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )

### Решение
Формулировка не ограничивает исполнителя как либо в написании кода кроме явного требования использования count loop и использования уже созданной сети и секьюрити группы
Я написал все в одном файле [count-vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/count-vm.tf)

### Подзадача 2
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" разных по cpu/ram/disk_volume , используя мета-аргумент for_each loop. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```
### Решение
В связи с ограничением от яндекса на использование ресурсов на диск, выставил у всех машин на минимальный равный 10gb \
Файл [variables.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/variables.tf) \
Файл [for_each-vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/for_each-vm.tf)

### Подзадача 3
3. ВМ, описанные в файле count-vm.tf, должны создаваться после ВМ, описанных в файле for_each-vm.tf
### Решение
Файл [count-vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/count-vm.tf) \
`depends_on = [yandex_compute_instance.db]`

### Подзадача 4
4. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub
### Решение
Файл [locals.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/locals.tf) \
Файл [for_each-vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/for_each-vm.tf)

## Задание 3
### Решение
Файл [disk_vm.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/disk_vm.tf)

## Задание 4
В файле ansible.tf создайте inventory-файл для ansible. Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции. Готовый код возьмите из демонстрации к лекции demonstration2. \
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
<img width="782" height="388" alt="image" src="https://github.com/user-attachments/assets/3f46ed65-7f81-4097-adc7-5faa018c9b77" />
### Решение
Файл [ansible.tftpl](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/ansible.tftpl) \
Файл [ansible.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/ansible.tf) \
Файл [inventory.ini](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_3/inventory.ini) \
<img width="636" height="176" alt="image" src="https://github.com/user-attachments/assets/dc6b7dc4-7d4d-4904-b909-6488b1e68a0c" />

<img width="1638" height="256" alt="image" src="https://github.com/user-attachments/assets/11be38b0-d940-4af9-8b08-79eb79816efa" />

