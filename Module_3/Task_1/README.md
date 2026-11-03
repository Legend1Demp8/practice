## Подготовка
### Создайте в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.
Задачу выполнил через Terraform так быстрее
<img width="1716" height="297" alt="image" src="https://github.com/user-attachments/assets/c4dd115f-d186-4ba8-b072-acfdf7510031" />

## Задача 1
### Допишите плейбук из задания 2 (Ранее были 2 Плея Vector + Clickhouse) добавив плей LightHouse
### Результат
[site.yml]()

## Задача 2
### Рекомендация
### Результат
Спасибо за рекомендацию

## Задача 3
### Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
### Результат
[site.yml]()

## Задача 4
### Подготовьте свой inventory-файл prod.yml.
### Результат
Файл инвентори создается автоматически на основе terraform проекта
```
cat inventory/prod.yml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 158.160.171.29
      ansible_user: ansible
      ansible_connection: ssh

vector:
  hosts:
    vector-01:
      ansible_host: 158.160.169.210
      ansible_user: vector
      ansible_connection: ssh

lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: 158.160.198.249
      ansible_user: lighthouse
      ansible_connection: ssh
```

## Задача 5
### Запустите ansible-lint site.yml
### Результат
<img width="1125" height="115" alt="image" src="https://github.com/user-attachments/assets/e748bbfd-ada6-4d12-be74-656806495e5f" />
Ошибок нет

## Задача 6
### Попробуйте запустить playbook на этом окружении с флагом --check
### Решение
ansible-playbook -i inventory/prod.yml site.yml --check
Check не выполняется поскольку дальше чем клонирования git репозитория мы не уходим

## Задача 7
### Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
ansible-playbook -i inventory/prod.yml site.yml --diff


## Задача 8
### Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
ansible-playbook -i inventory/prod.yml site.yml --diff


## Задача 9
### Подготовьте README.md-файл по своему playbook.
[README.md]()

## Задача 10
### Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-03-yandex
[Git]()
