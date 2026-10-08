## Задание 1
### Результат:
4) Исправьте намеренно допущенные синтаксические ошибки. Ответьте, в чём заключается их суть
Невнимательность (человеческий фактор) - standar**t**-v**4**
5) Подключитесь к консоли ВМ через ssh и выполните команду curl ifconfig.me

Скрин из ЛК Yandex.Cloud

Скрин из виртуальной машины

6) Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ
preemptible=true (Прерываемая) в процессе обучения поможет мне сэкономить грант и не забыть выключить виртуальную машину \
core_fraction=5 (Гарантированная доля vCPU), поможет дополнительно сэкономить мне грант до конца обучения поскольку тестовым виртуальным машинам не нужна 100% доля для vCPU

### Решение ошибок:

Найти ошибки в проекте
#### Ошибки на стадии terraform init:
---
* Ошибка: Версия терраформ была указана явно ~>1.12.0 тоесть в пределах 1.12 у нас выше
```
Решение: я поставил просто >1.12.0
Результат: Terraform init прошел успешно
```
#### Ошибки на стадии terraform validate:
---
* Ошибка: говорила что отсутствует файл ~/.authorized_key.json
```
Решение: перекинул ключ в необходимую директорию
Результат: Terraform validate прошел успешно
```
#### Ошибки на стадии terraform apply:
---
* Ошибка: rpc error: code = FailedPrecondition desc = Platform "standart-v4" not found
```
Решение: Читаю документацию на Yandex CLoud при создании вм раздел платформа https://yandex.cloud/ru/docs/compute/concepts/vm-platforms 
platform_id (String). The type of virtual machine to create.
Соответственно ответ прост - такого типа платформы не существует так еще и опечатка standarT-v4
Установил значение platform_id = "standard-v2" вместо platform_id = "standart-v4"
Результат: Terraform apply выдал новую ошибку
```
<img width="881" height="465" alt="image" src="https://github.com/user-attachments/assets/89b4f410-db1e-4285-a3de-2b46891588de" />

* Ошибка: the specified number of cores is not available on platform "standard-v2"; allowed core number: 2, 4
```
Решение: Тут все просто мой тип платформы не поддерживает конфигурацию при не четном кол-ве ядер у меня указано 1
Установил значение в два ядра cores = 2 вместо cores = 1
Результат: Terraform apply выдал новую ошибку
```

* Ошибка: rpc error: code = ResourceExhausted desc = Resource allocation is restricted
```
Решение: Проверил статус сервисов в Yandex Cloud - Написано что в зоне доступности B наблюдается проблемы
Как вариант попробовал сделать перенос на другую зону доступности.
Выполнил Terraform destroy следом поменял зону доступности с default = "ru-central1-a" на default = "ru-central1-d"
Выполнил Terraform apply - Не помогло та же ошибка
Попробовал создать виртуальную машину руками через веб - Не помогло та же ошибка
Жду восстановления доступности сервиса
```
<img width="974" height="682" alt="image" src="https://github.com/user-attachments/assets/1fcfd20c-a4fd-4eb2-91ba-b4d6e45c2b9d" />
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
