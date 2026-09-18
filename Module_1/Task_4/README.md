## Задача 1
### Результат Dockerfile.python
<img width="559" height="216" alt="image" src="https://github.com/user-attachments/assets/d80030c3-7981-4ee1-add6-4f4248f683b3" /> \
Вот коммит с добавлением файла: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/8cb62cb2243e519d3669c05e79e601fc8b9aadf5](https://github.com/Legend1Demp8/shvirtd-example-python/commit/8cb62cb2243e519d3669c05e79e601fc8b9aadf5)
### Результат .dockerignore
<img width="344" height="287" alt="image" src="https://github.com/user-attachments/assets/b6e222b4-24ea-405f-aaa2-28a0828d35cb" /> \
Вот коммит с изменениями кода: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/0ec648e75c5c329ee3c0f0024d4b9e12723a5931](https://github.com/Legend1Demp8/shvirtd-example-python/commit/0ec648e75c5c329ee3c0f0024d4b9e12723a5931)
### Результат Запуск через venv
<img width="1146" height="144" alt="image" src="https://github.com/user-attachments/assets/6dc88195-ac7a-4819-ab0f-5d29ad361020" />
<img width="1123" height="105" alt="image" src="https://github.com/user-attachments/assets/4ed87d91-7238-4fd8-956f-34f3f21356dd" /> \
### Результат "Динамическое название и использование таблицы"
Пришлось покопаться в ручную, автозамена не подходит, например в SQL запросах или print, нужны f строки \
Вот коммит с изменениями кода: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/b379febae207961101380d76d96ad56c93715521](https://github.com/Legend1Demp8/shvirtd-example-python/commit/b379febae207961101380d76d96ad56c93715521)
<img width="1156" height="249" alt="image" src="https://github.com/user-attachments/assets/d098f46c-8bf7-4217-b3cd-9bbdea59e109" />
<img width="1128" height="122" alt="image" src="https://github.com/user-attachments/assets/e026aab3-ba29-4909-bb47-2d65f841dae5" />
Проверка работы \
<img width="529" height="83" alt="image" src="https://github.com/user-attachments/assets/08981ec4-a250-439d-9f5a-b6ecd5fdfead" />
```
curl http://127.0.0.1:5000/requests
```



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
.dockerignore

haproxy/
nginx/

.env/

venv/
__pycache__/

schema.pdf
README.md
LICENSE

proxy.yaml

.git
.gitignore
```
* SingleStage Время сборки Building 21.0s
```
cat Dockerfile.python-singlestage

FROM python:3.12-slim

#  Ваш код здесь #
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

# Запускаем приложение с помощью uvicorn, делая его доступным по сети
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
```
* MultiStage Время сборки Building 73.9s
```
cat Dockerfile.python-multistage

FROM python:3.12-slim AS builder

#  Ваш код здесь #
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /usr/local /usr/local
COPY . .

# Запускаем приложение с помощью uvicorn, делая его доступным по сети
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
```

* Multistage имеет экономию но только за счет того, что я НЕ поставил флаг --no-cache-dir в Singlestage у pip install
В данном тесте Multistage проиграл в 50 секунд, а толку не добавил 
```
Без флага --no-cache-dir в Singlestage
task-4-python-multi:latest    1266390cb5e4        400MB           95MB
task-4-python-single:latest   3993aa1a9b19        490MB          139MB

С флагом --no-cache-dir в Singlestage разницы нет
task-4-python-multi:latest    1266390cb5e4        400MB           95MB
task-4-python-single:latest   18f051c37e53        400MB           95MB
```
</details>
