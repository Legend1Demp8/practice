## Задача 1
### Результат: Dockerfile.python
<img width="559" height="216" alt="image" src="https://github.com/user-attachments/assets/d80030c3-7981-4ee1-add6-4f4248f683b3" /> \
Вот коммит с добавлением файла: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/8cb62cb2243e519d3669c05e79e601fc8b9aadf5](https://github.com/Legend1Demp8/shvirtd-example-python/commit/8cb62cb2243e519d3669c05e79e601fc8b9aadf5)
### Результат: .dockerignore
<img width="344" height="287" alt="image" src="https://github.com/user-attachments/assets/b6e222b4-24ea-405f-aaa2-28a0828d35cb" /> \
Вот коммит с добавлением файла: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/0ec648e75c5c329ee3c0f0024d4b9e12723a5931](https://github.com/Legend1Demp8/shvirtd-example-python/commit/0ec648e75c5c329ee3c0f0024d4b9e12723a5931)
### Результат: Запуск через venv
<img width="1146" height="144" alt="image" src="https://github.com/user-attachments/assets/6dc88195-ac7a-4819-ab0f-5d29ad361020" />
<img width="1123" height="105" alt="image" src="https://github.com/user-attachments/assets/4ed87d91-7238-4fd8-956f-34f3f21356dd" />

### Результат: Динамическое название и использование таблицы
Пришлось покопаться в ручную, автозамена не подходит, например в SQL запросах или print, нужны f строки \
Вот коммит с изменениями кода: [https://github.com/Legend1Demp8/shvirtd-example-python/commit/b379febae207961101380d76d96ad56c93715521](https://github.com/Legend1Demp8/shvirtd-example-python/commit/b379febae207961101380d76d96ad56c93715521)
<img width="1156" height="249" alt="image" src="https://github.com/user-attachments/assets/d098f46c-8bf7-4217-b3cd-9bbdea59e109" />
Смотрим что таблица netology добавилась в базу данных
<img width="1128" height="122" alt="image" src="https://github.com/user-attachments/assets/e026aab3-ba29-4909-bb47-2d65f841dae5" />
Проверка работы бэкенда \
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

## Задание 2
### Результат:
<img width="1575" height="206" alt="image" src="https://github.com/user-attachments/assets/c6b6ad90-6a1e-4cf0-b5a3-54a53e953a19" />

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Дал своей сервисной учетной записи права на создание и управление Registry | container-registry.editor
* Создал Registry
```
yc container registry create --name my-first-registry
done (1s)
id: crp2h22vhc22kag2filt
folder_id: b2gef2heh2kn22cp22mu
name: my-first-registry
status: ACTIVE
created_at: "2026-09-18T11:24:07.237Z"
```
* Подключил Registry к Docker
```
yc container registry configure-docker
docker configured to use yc --profile "admin-vm" for authenticating "cr.yandex" container registries
Credential helper is configured in '/root/.docker/config.json'
```
* Тегирую свой образ 
```
docker tag task-4-python-multi:latest cr.yandex/crp2h22vhc22kag2filt/task-4-python-multi:latest
```
* Делаю Push в Yandex
```
docker push cr.yandex/crp2h22vhc22kag2filt/task-4-python-multi:latest
```
* Проверяю наличие всего в веб интерфейсе
<img width="1128" height="196" alt="image" src="https://github.com/user-attachments/assets/32b64a17-76df-4ec5-936e-a360a734aacd" />
<img width="1559" height="208" alt="image" src="https://github.com/user-attachments/assets/c25c7bfb-451f-46c9-b03f-ab1ebd5f7c92" />

* Проверяю уязвимости
<img width="1575" height="206" alt="image" src="https://github.com/user-attachments/assets/bff86c85-424e-488b-9158-ba45a565348d" />

</details>

## Задача 3
### Результат:
Проверяем что запустилось
<img width="1372" height="301" alt="image" src="https://github.com/user-attachments/assets/bcb6a5f2-722e-423b-b269-932b5559b7ab" />
Проверяем что в Таблицу попадают значения
<img width="637" height="688" alt="image" src="https://github.com/user-attachments/assets/296892ef-64ae-451c-8599-e910e18986d4" />

### Изучение проекта от proxy.yaml:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Проверяем исходя из описания проекта
```
Клиент → 
1) Nginx (8090) → 
2) HAProxy (8080) → 
3) FastAPI App (5000) → 
4) MySQL (Странно что тут не указано 3306 ведь если я изменю его при запуске все сломается)
```
* Трафик приходит из мира на NGINX
В файле proxy.yaml указано
```
  ingress-proxy:
    image: nginx:latest
    restart: always
    network_mode: host
    volumes:
    - ./nginx/ingress/default.conf:/etc/nginx/conf.d/default.conf:rw
    - ./nginx/ingress/nginx.conf:/etc/nginx/nginx.conf:rw
```
Отсюда понятно, что по сети NGINX будет находится на уровне OS -> network_mode: host \
Исходя из default.conf видно явное проксирование на 127.0.0.1:8080 он же HAPROXY
* Трафик после NGINX попадает на HAPROXY
В файле proxy.yaml указано
```
  reverse-proxy:
    image: haproxy:2.4
    restart: always
    networks:
        backend: {}
    ports:
    - "127.0.0.1:8080:8080"
    volumes:
    - ./haproxy/reverse/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:rw
```
Отсюда понятно, что по сети HAPROXY будет находится за сетевым мостом самого docker и иметь ip из сети 172.20.0.0/24 \
А порт 8080 будет проброшен из основной системы в контейнер
В файле haproxy.cfg
```
global
  maxconn 1000

defaults
default-server init-addr none

frontend http_front
bind *:8080
mode http
default_backend http_back



backend http_back
balance roundrobin
mode http
server web 172.20.0.5:5000 check
```
Слушаем 8080 делаем раундробин и что-то про хелсчек \
Явно зашит IP нашего бекэнда возможно в дальнейшем нужно будет масштабировать

</details>

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>

* Пишу Dockerfile.mysql
* Пишу Файл compose.yaml исходя из условий задания
```
include:
  - proxy.yaml

services:
  db:
    build:
      context: .
      dockerfile: Dockerfile.mysql
    restart: always
    networks:
      backend:
        ipv4_address: 172.20.0.10
    environment:
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
  web:
    build:
      context: .
      dockerfile: Dockerfile.python
    restart: always
    depends_on:
      - db
    networks:
      backend:
        ipv4_address: 172.20.0.5
    environment:
      - DB_NAME=${MYSQL_DATABASE}
      - DB_USER=${MYSQL_USER}
      - DB_PASSWORD=${MYSQL_PASSWORD}
      - DB_HOST=db # 172.20.0.10
      - DB_TABLE_NAME=${MYSQL_TABLE_NAME}
```
* Запускаю проект
```
docker compose up --build -d
```
```
docker compose ps
NAME                                     IMAGE                        COMMAND                  SERVICE         CREATED          STATUS          PORTS
shvirtd-example-python-db-1              shvirtd-example-python-db    "docker-entrypoint.s…"   db              47 seconds ago   Up 45 seconds   3306/tcp, 33060/tcp
shvirtd-example-python-ingress-proxy-1   nginx:latest                 "/docker-entrypoint.…"   ingress-proxy   47 seconds ago   Up 46 seconds
shvirtd-example-python-reverse-proxy-1   haproxy:2.4                  "docker-entrypoint.s…"   reverse-proxy   47 seconds ago   Up 45 seconds   127.0.0.1:8080->8080/tcp
shvirtd-example-python-web-1             shvirtd-example-python-web   "uvicorn main:app --…"   web             46 seconds ago   Up 45 seconds
```
* Проверяю работу локально
```
curl -L http://127.0.0.1:8090
"TIME: 2026-09-18 13:25:11, IP: 127.0.0.1"
```
</details>

## Задача 4
### Результат: [https://github.com/Legend1Demp8/shvirtd-example-python](https://github.com/Legend1Demp8/shvirtd-example-python)
Самый простой и минималистичный bash скрипт, можно его улучшать по миллиону раз, на повторный запуск и тд и тп но пока не интересно да и в условиях этого нет \
<img width="607" height="151" alt="image" src="https://github.com/user-attachments/assets/b1f90307-a40d-4074-80d8-ffcaf6cda382" />

Выполняю проверку работы из разных точек \
<img width="822" height="733" alt="image" src="https://github.com/user-attachments/assets/324133df-a33c-425f-9a31-4ad82a8faeac" />

Вывожу информацию из таблицы \
<img width="415" height="254" alt="image" src="https://github.com/user-attachments/assets/52920362-224e-448d-8798-9ee57714fc96" />

## Задача 5
### Результат:
Как я понял образ https://hub.docker.com/r/schnitzler/mysqldump/ \
Не поможет мне выполнить задачу вот его ошибка 
```
mysqldump: Got error: 1045: "Plugin caching_sha2_password could not be loaded: Error loading shared library 
/usr/lib/mariadb/plugin/caching_sha2_password.so: No such file or directory" when trying to connect
```
Он собран последний раз 3года назад, не хочу менять шифрование пароля в БД на более низкое сделаю просто через другой образ 

Зафиксировал имя сети в файле proxy.yaml чтобы не заниматься парсингом из-за ерунды \
<img width="606" height="438" alt="image" src="https://github.com/user-attachments/assets/fd1300c0-1289-4604-9908-64408f9e7a32" />

Создал самый простой файл backup.sh \
<img width="937" height="377" alt="image" src="https://github.com/user-attachments/assets/d0ff3b3e-6bfb-4ed7-a5b0-4403fd847887" />

Закронил скрипт \
<img width="578" height="381" alt="image" src="https://github.com/user-attachments/assets/5898df0f-a8f3-42c0-9711-c62f8ccc940c" />

Вывел в ls \
<img width="680" height="189" alt="image" src="https://github.com/user-attachments/assets/9028af75-4c7b-4853-aa02-0ac1f016edff" />

</details>

## Задача 6
### Результат:
* Извлекаем через docker save
<img width="912" height="86" alt="image" src="https://github.com/user-attachments/assets/c10ab92b-0881-4f93-b5a6-c08a29f68118" />

Шаги вот
1) ``` docker save hashicorp/terraform:latest -o terraform_image.tar ```
2) ``` mkdir terraform_layers ```
3) ``` tar -xf terraform_image.tar -C terraform_layers  ```
4) ``` cd terraform_layers ```
5) ``` for f in ./blobs/sha256/*; do tar -tf "$f" 2>/dev/null | grep -qE '(^|/)bin/terraform$' && echo "НАЙДЕН: $f"; done ```
6) ``` extracted ```
7) ``` tar -xf ./blobs/sha256/2213d3f768a98affdbc62b57e382cf20ba446135efda646d18dc6a780bfedd82 -C ./extracted bin/terraform ```
8) ``` chmod +x ./extracted/bin/terraform ```
9) ``` ./extracted/bin/terraform version ```

* Извлекаем через Dive \
Честно не получилось Ctr+E не работает
<img width="1637" height="937" alt="image" src="https://github.com/user-attachments/assets/f15a80f0-2e5b-4d7f-b003-01d7d6de942e" />

```
docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$(pwd)/extracted-dive":/tmp \
  docker.io/wagoodman/dive:latest hashicorp/terraform:latest
```

