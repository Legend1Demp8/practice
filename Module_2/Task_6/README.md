## Git Terraform Проекта
[Git](https://github.com/Legend1Demp8/terraform-06)
## Git Python Backend Проекта
[Git](https://github.com/Legend1Demp8/netology-python)

## Подготовка
### 1. Использую ранее созданный S3
<img width="1065" height="211" alt="image" src="https://github.com/user-attachments/assets/becd52fc-57b8-45d3-acbc-c2df1aefa16a" />

### 2. Backend.tf
- [backend.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/backend.tf)

### 3. Проверяю State-lock в два окна
<img width="1605" height="254" alt="image" src="https://github.com/user-attachments/assets/5e266e79-9f28-4183-81b9-0a21f74ce62d" />
<img width="1611" height="320" alt="image" src="https://github.com/user-attachments/assets/5f4afef3-085b-49c1-85a7-915f4123c44a" />


```
 Error: Error acquiring the state lock
│
│ Error message: operation error S3: PutObject, https response error StatusCode: 412, RequestID: 316d86c1f170a784, HostID: , api error PreconditionFailed: At least one of the pre-conditions you
│ specified did not hold
│ Lock Info:
│   ID:        172eeb44-7ce0-e960-bc21-99c02f58d4aa
│   Path:      terraform-state-netology-06/terraform.tfstate
│   Operation: OperationTypeApply
│   Who:       root@gw-spb
│   Version:   1.16.5
│   Created:   2026-11-02 16:07:51.392601776 +0000 UTC
│   Info:
│
│
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
```


## Логика проекта
### 1. Создаем сеть
<img width="1367" height="207" alt="image" src="https://github.com/user-attachments/assets/6ef667b6-3a4b-4074-9869-402b6fe6a666" />

### 2. Создаем подсеть
<img width="1366" height="450" alt="image" src="https://github.com/user-attachments/assets/9ccc6e41-981d-42fa-893b-b2c7c4b4fcb1" />

### 3. Создаем 2 секьюрити группы, разрешаем ходить к базе по порту 3306 только из сети default_cidr
<img width="1395" height="241" alt="image" src="https://github.com/user-attachments/assets/96d66287-3085-41ef-a98f-c75e56c2b7cd" />

### 4. Создаем Registry куда зальем образ
<img width="1334" height="209" alt="image" src="https://github.com/user-attachments/assets/c4b37063-10ca-440b-9950-9259817c23e5" />

### 5. Создаем сервисную учетку с доступом к Registry
<img width="1132" height="68" alt="image" src="https://github.com/user-attachments/assets/1efc654e-1977-47e9-ae47-9129bebf50c8" />

### 6. Создаем LockBox закидываем туда пароль от БД
<img width="1276" height="248" alt="image" src="https://github.com/user-attachments/assets/58e554dd-74b2-4c9a-aa4d-e4d0b7e02988" />

### 7. Создаем кластер Mysql
<img width="1396" height="282" alt="image" src="https://github.com/user-attachments/assets/c2bea1df-58ed-4a86-b138-2fc8bffca446" />

### 8. Создаем БД
<img width="841" height="337" alt="image" src="https://github.com/user-attachments/assets/f7036ae4-f779-4c46-884c-ab5edf987d3a" />

### 9. Создаем пользователя в БД
<img width="1341" height="336" alt="image" src="https://github.com/user-attachments/assets/c5a2a084-dc63-4a3b-961d-36a8bc66c2e2" />

### 8. Создаем ВМ, ВМ в момент запуска билдит образ заливает в реджистри и запускает его с коннектом к БД
<img width="1710" height="211" alt="image" src="https://github.com/user-attachments/assets/cc2edb21-d4f0-413e-ab42-f4ab265fd449" />

### 9. Привязываем Сервисную учетку к виртуальной машине для доступа к Registry
<img width="1226" height="414" alt="image" src="https://github.com/user-attachments/assets/311c1072-8496-450d-b33f-dfa627512ca2" />

### 10. Проверяем что машина залила образ в Registry
<img width="835" height="363" alt="image" src="https://github.com/user-attachments/assets/2ffe5edb-0fb5-4d3c-a13f-af49529467db" /> \
<img width="1403" height="347" alt="image" src="https://github.com/user-attachments/assets/abb8f5a6-ff41-4727-9d2b-0928da89e2ce" />

### 11. Проверяем работу приложения
<img width="1534" height="394" alt="image" src="https://github.com/user-attachments/assets/dd23d1f2-7fdc-4a8a-8f80-70d26276a40e" />

## Ресурсы проекта
Я вижу его следующим образом, прошу поправить меня там где я не прав \
Основные ресурсы которые я использовал: \
1) Registry
- [registry.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/registry.tf)
2) Сервисная учётка созданная для Registry и привязаная к вм
- [user.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/user.tf)
3) Lockbox
- [lockbox.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/lockbox.tf)
4) Одна виртуальная машина (Скачивает Dockerfile, Билдит, Заливает на Registry, Запускает)
- [vms.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/vms.tf)
5) Git для нашего Бэкенда, скачиваем, билдим
- [Git](https://github.com/Legend1Demp8/netology-python)
4) Секьюрити группы для ВМ и для Приложения - сделал разные потому что 3306
- [security.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/security.tf)
5) Сеть и подсеть
- [network.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/network.tf)
6) Cloud init для ВМ
- [cloud-init.yml](https://github.com/Legend1Demp8/terraform-06/blob/master/cloud-init.yml)
7) База данных Mysql
- [mysql.tf](https://github.com/Legend1Demp8/terraform-06/blob/master/mysql.tf)
