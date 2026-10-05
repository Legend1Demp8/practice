## Подготовка к заданию
1) Установить Terraform 
<img width="1635" height="427" alt="image" src="https://github.com/user-attachments/assets/582d4f13-acbe-4b93-aeb1-bc19ff310784" />

2) Склонировать репозиторий 
<img width="820" height="268" alt="image" src="https://github.com/user-attachments/assets/4f0d6792-9a86-441d-9450-7d85ec78d273" />

3) Убедитесь, что в вашей ОС установлен docker 
<img width="569" height="379" alt="image" src="https://github.com/user-attachments/assets/6b45ba62-958f-4603-ae61-76141718c08b" />

## Задание 1
### Результат:
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
</details>details>
