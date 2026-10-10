## Задание 1
### Результат:
4) Исправьте намеренно допущенные синтаксические ошибки. Ответьте, в чём заключается их суть
Невнимательность (человеческий фактор) - standar**t**-v**4**
5) Подключитесь к консоли ВМ через ssh и выполните команду curl ifconfig.me

Скрин из ЛК Yandex.Cloud \
<img width="1730" height="375" alt="image" src="https://github.com/user-attachments/assets/64f5e869-31f1-4bea-b88b-a80b8d62f47b" />

Скрин из виртуальной машины \
<img width="501" height="192" alt="image" src="https://github.com/user-attachments/assets/7e3a61ab-1e1a-4e25-8eb2-9a384b966a89" />

6) Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ
preemptible=true (Прерываемая) в процессе обучения поможет мне сэкономить грант и не забыть выключить виртуальную машину \
core_fraction=5 (Гарантированная доля vCPU), поможет дополнительно сэкономить мне грант до конца обучения поскольку тестовым виртуальным машинам не нужна 100% доля для vCPU

### Решение и разбор ошибок:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
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

</details>

## Задание 2
### Результат:
Создали необходимые переменные
<img width="1028" height="655" alt="image" src="https://github.com/user-attachments/assets/69364701-3dc6-48c4-89bc-8fe5d40a0ca9" />

Проверка terraform plan
<img width="1019" height="85" alt="image" src="https://github.com/user-attachments/assets/506b0e2d-a243-469c-8949-e284fc0396cb" />

# Задание 3

# Задание 4

# Задание 5

# Задание 6
