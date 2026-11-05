## Git Проекта

## Git Ролей
[vector-role](https://github.com/Legend1Demp8/vector-role) \
[lighthouse-role](https://github.com/Legend1Demp8/lighthouse-role)

## Задание 1
### Создайте в старой версии playbook файл requirements.yml и заполните его содержимым
### Решение
[requirements.yml]()

## Задание 2
### При помощи ansible-galaxy скачайте себе эту роль
### Решение
```
ansible-galaxy install -r requirements.yml
Starting galaxy role install process
- extracting clickhouse to /root/.ansible/roles/clickhouse
- clickhouse (1.13) was installed successfully
```

## Задание 3
### Создайте новый каталог с ролью при помощи ansible-galaxy role init vector-role
### Решение
```
ansible-galaxy role init vector-role
- Role vector-role was created successfully
```

## Задание 4
### На основе tasks из старого playbook заполните новую role. Разнесите переменные между vars и default
### Решение
vector-role:
- vars [vars](https://github.com/Legend1Demp8/vector-role/blob/master/vars/main.yml)
- default [default](https://github.com/Legend1Demp8/vector-role/tree/master/templates)

lighthouse-role:
- vars [vars](https://github.com/Legend1Demp8/lighthouse-role/blob/master/vars/main.yml)
- default [default](https://github.com/Legend1Demp8/lighthouse-role/tree/master/templates)

## Задание 5
### Перенести нужные шаблоны конфигов в templates
### Решение
vector-role [templates](https://github.com/Legend1Demp8/vector-role/tree/master/templates) \
lighthouse-role [templates](https://github.com/Legend1Demp8/lighthouse-role/tree/master/templates)

## Задание 6
### Опишите в README.md обе роли и их параметры
### Решение
vector-role [README.md](https://github.com/Legend1Demp8/vector-role/blob/master/README.md) \
lighthouse-role [README.md](https://github.com/Legend1Demp8/lighthouse-role/blob/master/README.md)

## Задание 7
### Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.
### Решение
Выполнил

## Задание 8
### Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в requirements.yml в playbook.
### Решение
[vector-role](https://github.com/Legend1Demp8/vector-role) \
[lighthouse-role](https://github.com/Legend1Demp8/lighthouse-role)
<img width="612" height="207" alt="image" src="https://github.com/user-attachments/assets/d33e53a9-6e09-4461-b9b1-34115b347117" />
[requirements.yml]()

## Задание 9
### Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения roles с tasks.
### Решение
<img width="591" height="368" alt="image" src="https://github.com/user-attachments/assets/3f5cad46-f109-4c98-9790-65bb52e926f8" />
[site.yml]()

## Задание 10
### Выложите playbook в репозиторий.
### Решение
[ansible-04]()

## Задание 11
### В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.
### Решение
[vector-role](https://github.com/Legend1Demp8/vector-role)
[lighthouse-role](https://github.com/Legend1Demp8/lighthouse-role)
[ansible-04]()
