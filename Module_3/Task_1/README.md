## Подготовка
### Создайте в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.
Задачу выполнил через Terraform так быстрее
<img width="1716" height="297" alt="image" src="https://github.com/user-attachments/assets/c4dd115f-d186-4ba8-b072-acfdf7510031" />

## Задача 1
### Допишите плейбук из задания 2 (Ранее были 2 Плея Vector + Clickhouse) добавив плей LightHouse
[site.yml]()

## Задача 3
### Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
[site.yml]()

## Задача 4
### Подготовьте свой inventory-файл prod.yml.
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
Ошибок нет


## Задача 6
### Попробуйте запустить playbook на этом окружении с флагом --check

## Задача 7
### Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.

## Задача 8
### Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.

## Задача 9
### Подготовьте README.md-файл по своему playbook.

## Задача 10
### Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-03-yandex

