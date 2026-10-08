## Задание 1
### Результат:
Найти ошибки в проекте
* Ошибки на стадии terraform init:
1) Версия терраформ была указана явно ~>1.12.0 тоесть в пределах 1.12 у нас выше
Решение: я поставил просто >1.12.0
Terraform init прошел успешно
* Ошибки на стадии terraform validate:
1) Ошибка говорила что отсутствует файл ~/.authorized_key.json
Решение: перекинул ключ в необходимую директорию
Terraform validate прошел успешно
* Ошибки на стадии terraform apply:
---
1) rpc error: code = FailedPrecondition desc = Platform "standart-v4" not found
Решение: Читаю документацию на Yandex CLoud при создании вм 
```
platform_id (String). The type of virtual machine to create.
```
Соответственно ответ прост такого типа платформы не существует так еще и опечатка
<img width="881" height="465" alt="image" src="https://github.com/user-attachments/assets/89b4f410-db1e-4285-a3de-2b46891588de" />

Решение: Поставил standarD-v2
---
2) the specified number of cores is not available on platform "standard-v2"; allowed core number: 2, 4 \
Тут все просто мой тип не поддерживает конфигурацию при не четном кол-ве ядер у меня указано 1 \
Решение: Поставил 2 ядра \
---
3) rpc error: code = ResourceExhausted desc = Resource allocation is restricted \
Выделение ресурсов - ограничено, как я понял дело в том что произошел инцидент в зоне доступности B \
Решение: делаем Terraform destroy переезжаем на другую зону доступности изменяя default с зоны ru-central1-a на ru-central1-d \
* Не помогло \
Делаем виртуалку руками - таже ошибка значит дело не в коде а в инциденте - пока ожидаем \
<img width="1826" height="220" alt="image" src="https://github.com/user-attachments/assets/edade884-6890-4e64-8534-d8e7d6c2e4f8" />


### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
done
* Создайте сервисный аккаунт и ключ. service_account_key_file.
Было сделано из прошлых работ
* Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.
Сгенерировал ключ ed25519 и записал его в файл
<img width="821" height="86" alt="image" src="https://github.com/user-attachments/assets/88e83d57-37da-42eb-96e1-5c64066d7b96" />



</details>
