## Подготовка к заданию
1) Установить Terraform 
<img width="1635" height="427" alt="image" src="https://github.com/user-attachments/assets/582d4f13-acbe-4b93-aeb1-bc19ff310784" />

2) Склонировать репозиторий 
<img width="820" height="268" alt="image" src="https://github.com/user-attachments/assets/4f0d6792-9a86-441d-9450-7d85ec78d273" />

3) Убедитесь, что в вашей ОС установлен docker 
<img width="569" height="379" alt="image" src="https://github.com/user-attachments/assets/6b45ba62-958f-4603-ae61-76141718c08b" />

## Задание 1
### Результат:
Наш сгенерированный пароль это: \
Ключ: result \
Значение: J6r4ginPSclH94cQ
<img width="1118" height="746" alt="image" src="https://github.com/user-attachments/assets/a36317b6-0d9e-4669-863d-49a9720c0143" />

Запущенный контейнер и его код
<img width="1075" height="608" alt="image" src="https://github.com/user-attachments/assets/6e17f474-26ee-42d8-a360-b66e01637f02" />
Ссылка на код: [https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/main.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/main.tf)

Изменить имя контейнера на hello_world и показать docker ps
<img width="1003" height="83" alt="image" src="https://github.com/user-attachments/assets/30644b21-acd6-4476-9256-308e0b2e00c6" />

Чем опасен auto-approve
Автоматически подтвердить без участия пользователя (не пишим yes), логично - может наворотить дел
Пригодится наверно для автоматизации

Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
<img width="1003" height="176" alt="image" src="https://github.com/user-attachments/assets/94b0005c-c674-419d-9c7e-4b5bfe2da80b" />
<img width="555" height="156" alt="image" src="https://github.com/user-attachments/assets/4cd1fb9a-f451-4ad7-bd3e-137817db758a" />
Ссылка на код [https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/terraform.tfstate](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/terraform.tfstate)

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Подключил зеркало Яндекса для пакетов
```
~# pwd
/root/netology/ter-homeworks/01/src
```
```
~# cp .terraformrc /root/
```
* Скачал зависимости
```
terraform init
```
* Изучил файл .gitignore чтобы понять в каком файле можно хранить пароли: Ответ - personal.auto.tfvars
```
~# cat .gitignore
# own secret vars store.
personal.auto.tfvars
```
* Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
Наш сгенерированный пароль это:
Ключ: result
Значение: J6r4ginPSclH94cQ
<img width="1118" height="746" alt="image" src="https://github.com/user-attachments/assets/c149ec99-09a1-44d2-a643-3aed535a460d" />

* Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
```
~# terraform validate
Ошибка 1 - All resource blocks must have 2 labels: type, name (Все блоки ресурсов должны иметь 2 метки: Тип, Имя)
Ошибка 2 - A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes. (Имя должно начинаться с буквы или символа подчеркивания и может содержать только буквы, цифры, символы подчеркивания и дефисы.)
```
Ошибка 1 исправляем вот так
resource "docker_image" "nginx" {

Ошибка 2 исправляем вот так
resource "docker_container" "nginx" {
```
~# terraform validate
Ошибка 3 - A managed resource "random_password" "random_string_FAKE" has not been declared in the root module. (Управляемый ресурс «random_password» «random_string_FAKE» не был объявлен в корневом модуле.)
Ошибка 4 - Буква T в верхнем регистре resulT
```
Ошибка 3 исправляем вот так
name  = "example_${random_password.random_string.result}"

* Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps
<img width="1075" height="608" alt="image" src="https://github.com/user-attachments/assets/6e17f474-26ee-42d8-a360-b66e01637f02" />

Ссылка на код: [https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/main.tf](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/main.tf)

* Изменить имя контейнера на hello_world показать docker ps
```
меняем 
name  = "example_${random_password.random_string.result}"
на
name  = "hello_world"
```
<img width="1003" height="83" alt="image" src="https://github.com/user-attachments/assets/30644b21-acd6-4476-9256-308e0b2e00c6" />

* Чем опасен auto-approve
Автоматически подтвердить без участия пользователя (не пишим yes), логично - может наворотить дел
Пригодится наверно для автоматизации

* Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
```
terraform destroy
```
<img width="1003" height="176" alt="image" src="https://github.com/user-attachments/assets/94b0005c-c674-419d-9c7e-4b5bfe2da80b" />
<img width="555" height="156" alt="image" src="https://github.com/user-attachments/assets/4cd1fb9a-f451-4ad7-bd3e-137817db758a" />
Ссылка на код [https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/terraform.tfstate](https://github.com/Legend1Demp8/practice/blob/main/Module_2/Task_1/terraform.tfstate)

</details>
