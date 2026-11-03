## Подготовка
### Создайте в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.
Задачу выполнил через Terraform так быстрее
<img width="1716" height="297" alt="image" src="https://github.com/user-attachments/assets/c4dd115f-d186-4ba8-b072-acfdf7510031" />

## Задача 1
### Допишите плейбук из задания 2 (Ранее были 2 Плея Vector + Clickhouse) добавив плей LightHouse
### Результат
[site.yml](https://github.com/Legend1Demp8/ansible-03/blob/08-ansible-03-yandex/site.yml)

## Задача 2
### Рекомендация использования

## Задача 3
### Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
### Результат
[site.yml](https://github.com/Legend1Demp8/ansible-03/blob/08-ansible-03-yandex/site.yml) \
<img width="843" height="378" alt="image" src="https://github.com/user-attachments/assets/b67ce3eb-2e5e-466d-b567-c3648206a190" />
<img width="959" height="430" alt="image" src="https://github.com/user-attachments/assets/7d5b935f-55a6-4ff9-8407-675e9ccef3a0" />

## Задача 4
### Подготовьте свой inventory-файл prod.yml.
### Результат
Файл инвентори создается автоматически на основе terraform проекта
[inventory/prod.yml](https://github.com/Legend1Demp8/ansible-03/blob/08-ansible-03-yandex/inventory/prod.yml)

## Задача 5
### Запустите ansible-lint site.yml
### Результат
<img width="1125" height="115" alt="image" src="https://github.com/user-attachments/assets/e748bbfd-ada6-4d12-be74-656806495e5f" />
Ошибок нет

## Задача 6
### Попробуйте запустить playbook на этом окружении с флагом --check
### Решение
ansible-playbook -i inventory/prod.yml site.yml --check \
Check не выполняется, поскольку дальше чем клонирования git репозитория или установки репозитория мы не уходим, как система проверит пакет в репозитории который подключен через --check

## Задача 7
### Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
ansible-playbook -i inventory/prod.yml site.yml --diff
<img width="950" height="177" alt="image" src="https://github.com/user-attachments/assets/b364733f-112c-47c9-b6c9-74acd5c02f88" />

## Задача 8
### Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
ansible-playbook -i inventory/prod.yml site.yml --diff
<img width="965" height="156" alt="image" src="https://github.com/user-attachments/assets/a59d5ca5-db45-4e63-b3bc-a0a43db1da12" />

## Задача 9
### Подготовьте README.md-файл по своему playbook.
[README.md](https://github.com/Legend1Demp8/ansible-03/blob/08-ansible-03-yandex/README.md))

## Задача 10
### Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-03-yandex
[Git](https://github.com/Legend1Demp8/ansible-03/tree/08-ansible-03-yandex)
