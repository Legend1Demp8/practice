## Задача 1
### Результат: [https://hub.docker.com/repository/docker/legend1demp9/custom-nginx/general](https://hub.docker.com/repository/docker/legend1demp9/custom-nginx/general)
### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
  * Создал виртуальную машину на Yandex Cloud с OS Ubuntu 26.04
  * Подключился к ней через SSH
  * Установил Docker используя официальный скрипт установки с сайта
  ```
 curl -fsSL https://get.docker.com -o get-docker.sh
 sudo sh ./get-docker.sh --dry-run
  ```
  * Убедился что Docker Engine и Docker Client, а также Docker Compose встали в систему
  ```
 ~# docker version
Client: Docker Engine - Community
 Version:           29.8.0
Server: Docker Engine - Community
 Engine:
  Version:          29.8.0
  ```
  ```
  ~# docker compose version
  Docker Compose version v5.5.1
  ```
* Скачал образ nginx с версией 1.29.0 из DockerHub
```
docker pull nginx:1.29.0
```
* Проверил что образ скачался 
```
~# docker images
IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx:1.29.0   3ab4ed065a14        282MB         75.4MB
```
* Посмотрел подробную информацию о об образе
```
~# docker inspect nginx:1.29.0
```
* Убедился что скачал образ из официального репозитория
```
Зашел на Docker Hub официальный репозиторий Nginx выбрал Tag 1.29.0 и увидел ключ подписи, сравнил его с ключом в выводе команды Inspect
https://hub.docker.com/layers/library/nginx/1.29.0/images/sha256-0a8937a3b135265c379ac515e408fc88baa8f86d871ca80a83e059f5d7cec36a
```
* Убедился что в системе не подключены никакие левые зеркала для скачки образов
```
~# docker info
Не показывает строку Registry Mirrors
```
* Создал левое зеркало в файле /etc/docker/daemon.json 
```
Добавил следующий формат {"registry-mirrors": ["https://fontanka.ru"]}
Убедился что в Docker для применения изменений необходим перезапуск , поскольку docker info не отобразил новое зеркало
Выполнил перезагрузку Docker Server: 
~# systemctl restart docker
Убедился что теперь появилась новая графа в выводе docker info Registry Mirrors: https://fontanka.ru/
Откатил изменения, тест завершил
```
* Запустил загруженный образ nginx:1.29.0
```
~# docker run -d nginx:1.29.0
```
* Убедился в том что запуск успешен
```
~# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS     NAMES
1ff0bed9f9c3   nginx:1.29.0   "/docker-entrypoint.…"   9 seconds ago   Up 8 seconds   80/tcp    compassionate_saha
```
* Понял, что 80 порт слушается только внутри контейнера, на основной машине это никак не отображается
```
~# curl 127.0.0.1:80
curl: (7) Failed to connect to 127.0.0.1 port 80 after 0 ms: Could not connect to server

~# ss -lntup так же не показывает, что порт 80 не слушается
```
* Нашел ip запущенного контейнера 
```
docker inspect compassionate_saha | grep -i ip
```
* Попробовал обратится к Nginx по полученному ip
```
~# curl http://172.17.0.2:80

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
* Провалился в запущенный контейнер чтобы найти конфиг который необходимо изменить
```
~# docker exec -it compassionate_saha bash
```
* Нашел сам файл Nginx .conf и расположение файла index.html для стартовой страницы
```
/etc/nginx/conf.d/default.conf
/usr/share/nginx/html/index.html
```
* Поменял файл /usr/share/nginx/html/index.html самым простым способом
```
~# echo "<h1>Test NGINX</h1>" >> /usr/share/nginx/html/index.html
```
* Убедился что изменения применились
```
~# curl http://172.17.0.2:80
<h1>Test NGINX</h1>
```
* Выполнил перезагрузку виртуальной машины чтобы убедится, что изменения не фиксируются
* Новая загрузка показала, что изменения никак не зафиксировались и то что изменять файлы внутри контейнера руками это не выход
* Понял что необходимо создать свой образ (image) 
* Создал папку проекта а в нём создал файл Dockerimage а также необходимый файл index.html
```
~# mkdir my-nginx-project && cd my-nginx-project
```
```
~# vim Dockerfile
FROM nginx:1.29.0
COPY index.html /usr/share/nginx/html/index.html
```
```
~# vim index.html
<html>
   <head>
      Hey, Netology
   </head>
   <body>
      <h1>I will be DevOps Engineer!</h1>
   </body>
</html>
```
* Выполнил сборку образа с указанием тега из задания 1.0.0
```
~# docker build -t my-nginx:1.0.0 .
```
* Запустил свой образ и проверил вывод, все как нужно!
* Залогинился на Docker Hub
```
docker login
```
* Добавил новый tag своему образу по требованию Docker Hub по загрузке образа
```
~# docker tag my-nginx:1.0.0 docker-hub-login/my-nginx:1.0.0
```
* Снял старый Tag с образа
```
~# docker rmi my-nginx:1.0.0
```
* Выполнил отправку образа в свой Docker Hub
```
~# docker push docker-hub-login/my-nginx:1.0.0
```
* Начал выполнять проверку себя, удалил все образы и контейнеры в системе
```
~# docker rmi -f $(docker images -aq)
~# docker rm -f $(docker ps -aq)
~# docker pull docker-hub-login/my-nginx:1.0.0
~# docker inspect docker-hub-login/my-nginx:1.0.0
~# docker run -d docker-hub-login/my-nginx:1.0.0
~# curl http://172.17.0.2
```
* Всё готово

</details>

## Задача 2
### Результат:
### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Запустил обаз в необходимом формате с помощью команды
```
~# docker run -p 8080:80 --name "IvanovIvanIvanovich-custom-nginx-t2" -d docker-hub-login/custom-nginx:1.0.0
```
* Убедился что контейнер запущен и перенаправление портов работает
```
~# docker ps
CONTAINER ID   IMAGE                             COMMAND                  CREATED         STATUS         PORTS                                     NAMES
0e3b72e9633f   docker-hub-login/custom-nginx:1.0.0   "/docker-entrypoint.…"   9 seconds ago   Up 8 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   IvanovIvanIvanovich-custom-nginx-t2

~# curl http://127.0.0.1:8080
<html>
   <head>
      Hey, Netology
   </head>
   <body>
      <h1>I will be DevOps Engineer!</h1>
   </body>
</html>
```
* Переименовал уже запущенный контейнер
```
~# docker rename IvanovIvanIvanovich-custom-nginx-t2 custom-nginx-t2

~# docker ps
CONTAINER ID   IMAGE                             COMMAND                  CREATED         STATUS         PORTS                                     NAMES
0e3b72e9633f   docker-hub-login/custom-nginx:1.0.0   "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   custom-nginx-t2
```
</details>

## Задача 3
### Результат:
### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
  * Элемент списка 1
  * Элемент списка 2
  * Элемент списка 3
</details>

## Задача 4
### Результат:
### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
  * Элемент списка 1
  * Элемент списка 2
  * Элемент списка 3
</details>

## Задача 5
### Результат:
### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
  * Элемент списка 1
  * Элемент списка 2
  * Элемент списка 3
</details>
