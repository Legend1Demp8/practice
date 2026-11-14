## Git Проекта
[ansible-04](https://github.com/Legend1Demp8/ansible-04/blob/master/README.md)

## Подготовка
<img width="1238" height="214" alt="image" src="https://github.com/user-attachments/assets/cf437dc6-e59e-4ac9-869f-234a2df9b105" />

## Задание 1
### Создайте в старой версии playbook файл requirements.yml и заполните его содержимым
### Решение
[requirements.yml](https://github.com/Legend1Demp8/ansible-04/blob/master/requirements.yml)

## Задание 4
### Проверьте module на исполняемость локально.
### Решение
```
python hacking/test-module.py -m ./my_own_module.py -a 'path=/tmp/test_ansible_module.txt content="Hello from my_own_module!"'
```
<img width="1326" height="474" alt="image" src="https://github.com/user-attachments/assets/890f203c-4db3-4711-a91e-c9d03d2922c0" />

## Задание 5
### Напишите single task playbook и используйте module в нём.
### Решение
```
- name: Test custom module
  hosts: localhost
  connection: local
  gather_facts: false
  tasks:
    - name: Create a text file using my_own_module
      my_own_module:
        path: /tmp/playbook_test.txt
        content: "File created via playbook!"
```

## Задание 6
### Проверьте через playbook на идемпотентность.
### Решение
<img width="1633" height="422" alt="image" src="https://github.com/user-attachments/assets/5e159e91-7a4e-4174-8318-91a571373ee9" />

## Задание 7
### Выйдите из виртуального окружения.
### Решение
```
deactivate
```

## Задание 8
### Инициализируйте новую collection: ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
### Решение
```
ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
```

## Задание 9
### В эту collection перенесите свой module в соответствующую директорию.
### Решение
```
mkdir -p my_own_namespace/yandex_cloud_elk/plugins/modules
cp my_own_module.py my_own_namespace/yandex_cloud_elk/plugins/modules/
```

## Задание 10
### Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module.
### Решение
```
cd my_own_namespace/yandex_cloud_elk/roles
ansible-galaxy role init my_own_role
```
[plugins/modules/my_own_module.py]()
[roles/my_own_role/defaults/main.yml]()
[roles/my_own_role/tasks/main.yml]()

## Задание 11
### Шаг 11. Создайте playbook для использования этой role.

## Задание 12
### Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег 1.0.0 на этот коммит.
### Решение
[github](https://github.com/Legend1Demp8/my_own_collection)

## Задание 13
### Создайте .tar.gz этой collection: ansible-galaxy collection build в корневой директории collection.
### Решение
```
ansible-galaxy collection build
```
