## Задача 1
### Результат: [https://github.com/Legend1Demp8/shvirtd-example-python](https://github.com/Legend1Demp8/shvirtd-example-python)
### Самостоятельное задание по MySQL
<details>
  <summary>Нажмите, чтобы открыть</summary>
* Создал отдельную директорию mysql для описания Dockerfile под Mysql
```
mkdir mysql
cd mysql
```
* Создал необходимый SQL скрипт инициализации для базы MySQL
```
vim init.sql
CREATE DATABASE IF NOT EXISTS example;
CREATE USER IF NOT EXISTS 'app'@'%' IDENTIFIED BY 'very_strong';
GRANT ALL PRIVILEGES ON example.* TO 'app'@'%';
FLUSH PRIVILEGES;
```
* Описал Dockerfile для образа
```
# Не использовал CMD или ENTRYPOINT потому что по условиям прошедшего вебинара 
# понял что они наследуются из базового образа, в нашем случае CMD ["mysqld"]
FROM mysql:8.0
COPY init.sql /docker-entrypoint-initdb.d/
```
* Запустил docker build
```
docker build -t task-4-mysql .
```
* Запустил Контейнер
```
docker run --rm -d --name task-4-mysql -e MYSQL_ROOT_PASSWORD=very_strong -p 3306:3306 task-4-mysql
```
* Проверил что база-данных и пользователь создались
```
docker exec -it task-4-mysql mysql -u app -pvery_strong -D example -e "SELECT DATABASE();"
```
* Проверил что порт слушается
```
ss -lntup | grep 3306
nc 127.0.0.1 3306
```
</details>

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Сделал fork основного проекта https://github.com/netology-code/shvirtd-example-python
* Сделал clone форкнутого проекта к себе на виртуальную машину
* Создал файл Docker.python на основе существующего Dockerfile
```
cd shvirtd-example-python
cp Dockerfile{,.python}
```
* Создал файл .dockerignore
```
Dockerfile*
README.md
LICENSE
schema.pdf
haproxy/
nginx/
proxy.yaml
.env
.git/
.gitignore
venv
```
* Согласно заданию изменил файл Dockerfile.python для успешного запуска приложения
```
FROM python:3.12-slim

#  Ваш код здесь #
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# Запускаем приложение с помощью uvicorn, делая его доступным по сети
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
```

* Сделал multistage но вес не изменился. Базовый образ одинаков
```
FROM python:3.12-slim AS builder

#  Ваш код здесь #
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /usr/local /usr/local
COPY . .

# Запускаем приложение с помощью uvicorn, делая его доступным по сети
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
```
```
my-python-app-multi:latest           159acc985c09        400MB           95MB    U
my-python-app:latest                 f4e66c309f74        400MB           95MB    U
```
</details>
