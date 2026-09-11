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
<img width="1637" height="505" alt="2" src="https://github.com/user-attachments/assets/20e6d881-ca85-4801-a5d4-02ba8e717b90" />
Прошу заметить что grep 127.0.0.1:8080 не работает
<img width="1592" height="214" alt="image" src="https://github.com/user-attachments/assets/0a8ef59e-cb56-438e-ab9b-f83fc1ee09b0" />

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
* Выполнил команду 
```
~# date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html
```

</details>

## Задача 3
### Результат:
Передаю сигнал SIGINT прямо в контейнер
<img width="1324" height="247" alt="image" src="https://github.com/user-attachments/assets/e29fe83c-a5eb-44c4-93f7-6ca5806e757c" />

Изменяю порт в default конфигурации Nginx с 80 на 81 и применяю конфигурацию
<img width="783" height="350" alt="image" src="https://github.com/user-attachments/assets/5263b1a3-faf1-410a-856e-d06fe9b58b60" />

Переназначаю порт контейнера с 80 на 81, а также проброс портов с 8080->80 на 8080->81 не удаляя контейнер
<img width="1341" height="438" alt="image" src="https://github.com/user-attachments/assets/b42197e5-3dea-46c7-a960-1bd79bcd7b06" />

Удалил контейнер не останавливая его
<img width="1305" height="398" alt="image" src="https://github.com/user-attachments/assets/88d7c121-6c07-48dc-9b5c-d2cb2071c717" />


### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>

* Подключаюсь к вводу выводу необходимого контейнера
```
docker attach custom-nginx-t2
```
* Передаю в процесс сигнал SIGINT нажатием клавиши Ctrl+C
```
^C
2026/09/11 19:27:19 [notice] 1#1: signal 2 (SIGINT) received, exiting
```
* Процесс ожидаемо останавливает свою работу по нашей просьбе
* Запускаю контейнер обратно и подключаюсь запуская bash
```
~# docker start custom-nginx-t2
~# docker exec -it custom-nginx-t2 bash
```
* Выполняю установку текстового редактора vim
```
~# apt-get update
~# apt-get install -y vim
```
* Меняю порт в дефолтном сайте NGINX с 80 на 81 и проверяю это внутри контейнера а также выхожу из контейнера
```
~# vim /etc/nginx/conf.d/default.conf
~# nginx -s reload
~# curl http://127.0.0.1:80 ; curl http://127.0.0.1:81
curl: (7) Failed to connect to 127.0.0.1 port 80 after 0 ms: Couldn't connect to server
<html>
   <head>
      Hey, Netology
   </head>
   <body>
      <h1>I will be DevOps Engineer!</h1>
   </body>
</html>
~# exit
```
* Проверяю прослушиваемые порты на основной машине все без изменений
```
~# ss -tlpn | grep 8080
LISTEN 0      4096         0.0.0.0:8080      0.0.0.0:*    users:(("docker-proxy",pid=2130,fd=8))
LISTEN 0      4096            [::]:8080         [::]:*    users:(("docker-proxy",pid=2135,fd=8))
```
* Проверяю пробросы портов в свой контейнер
```
~# docker port custom-nginx-t2
80/tcp -> 0.0.0.0:8080
80/tcp -> [::]:8080
```
* Пытаюсь воспользоваться пробросом порта
```
~# curl http://127.0.0.1:8080
curl: (56) Recv failure: Connection reset by peer
```
* Останавливаю контейнер и сам докер демон
```
~# docker stop custom-nginx-t2
~# systemctl stop docker
```
* Редактирую конфигурационные файлы контейнера
```
~# vim /var/lib/docker/containers/b6831b666a5e3a68df9264dbdfc6d44ce64ace5425956da9e02dca1252454940/hostconfig.json
~# vim /var/lib/docker/containers/b6831b666a5e3a68df9264dbdfc6d44ce64ace5425956da9e02dca1252454940/config.v2.json
```
* Запускаю докер демон, а также сам контейнер
```
~# systemctl start docker
~# docker start custom-nginx-t2
```
* Удалил контейнер не останавливая его
```
~# docker ps
~# docker rm -f custom-nginx-t2
~# docker ps -a
```
</details>

## Задача 4
### Результат:
Установка образов и запуск двух контейнеров centos и debian а также отображение содержимого текущего каталога
<img width="991" height="407" alt="image" src="https://github.com/user-attachments/assets/c83ceb75-4d44-49bc-8ff2-96a8a5b0030b" />
Создание файла в контейнере Centos а также в основной системе и отображение каталога /data в контейнере debian
<img width="722" height="560" alt="image" src="https://github.com/user-attachments/assets/6fa89d3f-eee8-449a-9b30-136713674263" />

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Загрузка образов и запуск контейнеров CentOS и Debian
```
~# docker run -dit -v $(pwd):/data --name "centos7" centos:centos7
~# docker run -dit -v $(pwd):/data --name "debian-trixie" debian:trixie
```
* Вывод текущего каталога
```
~# ls -lah
total 68K
drwxr-x--- 6 ubuntu ubuntu 4.0K Sep 11 13:27 .
drwxr-xr-x 3 root   root   4.0K Sep 11 11:31 ..
-rw------- 1 ubuntu ubuntu  491 Sep 11 16:00 .bash_history
-rw-r--r-- 1 ubuntu ubuntu  220 Feb 13  2026 .bash_logout
-rw-r--r-- 1 ubuntu ubuntu 3.7K Feb 13  2026 .bashrc
drwx------ 2 ubuntu ubuntu 4.0K Sep 11 11:32 .cache
drwx------ 3 ubuntu ubuntu 4.0K Sep 11 14:19 .docker
-rw-r--r-- 1 ubuntu ubuntu  807 Feb 13  2026 .profile
drwx------ 2 ubuntu ubuntu 4.0K Sep 11 11:31 .ssh
-rw------- 1 ubuntu ubuntu 2.2K Sep 11 13:23 .viminfo
-rw-rw-r-- 1 ubuntu ubuntu  24K Sep 11 11:35 get-docker.sh
drwxrwxr-x 2 ubuntu ubuntu 4.0K Sep 11 13:58 my-nginx-project
```
* Вхожу в контейнер Centos и создаю файл в /data а также выхожу из контейнера
```
~# docker exec -it centos7 bash
~# touch /data/centos.txt
~# exit
```
* Создаю дополнительный файл в основной системе и вхожу в Debian, отображаю директорию /data
```
~# touch ./ubuntu.txt
~# docker exec -it debian-trixie bash
~# ls -lah /data/
total 68K
drwxr-x--- 6 1000 1000 4.0K Sep 11 21:17 .
drwxr-xr-x 1 root root 4.0K Sep 11 21:15 ..
-rw------- 1 1000 1000  491 Sep 11 16:00 .bash_history
-rw-r--r-- 1 1000 1000  220 Feb 13  2026 .bash_logout
-rw-r--r-- 1 1000 1000 3.7K Feb 13  2026 .bashrc
drwx------ 2 1000 1000 4.0K Sep 11 11:32 .cache
drwx------ 3 1000 1000 4.0K Sep 11 14:19 .docker
-rw-r--r-- 1 1000 1000  807 Feb 13  2026 .profile
drwx------ 2 1000 1000 4.0K Sep 11 11:31 .ssh
-rw------- 1 1000 1000 2.2K Sep 11 13:23 .viminfo
-rw-r--r-- 1 root root    0 Sep 11 21:16 centos.txt
-rw-rw-r-- 1 1000 1000  24K Sep 11 11:35 get-docker.sh
drwxrwxr-x 2 1000 1000 4.0K Sep 11 13:58 my-nginx-project
-rw-r--r-- 1 root root    0 Sep 11 21:17 ubuntu.txt
```
</details>

## Задача 5
### Результат:
Создаю директорию, а также создаю файлы Docker compose и запускаю. (Вижу, что docker compose видит два конфига но запускает только один)
Прочитав инструкцию понял что Docker compose предпочитает первый вариант над вторым для запуска
<img width="1257" height="290" alt="image" src="https://github.com/user-attachments/assets/8b2168b3-f9b8-49b2-af6f-58183ab007da" />
Делаю в основном файле compose.yaml include docker-compose.yaml и запускаю после проверяю статус запуска
<img width="1339" height="290" alt="image" src="https://github.com/user-attachments/assets/8d731727-f3dc-4053-aa63-4ff6c6667cb6" />
Создаю tag для образа из прошлых заданий и отправляю в свой локальный registry, просматриваю то что загружено в registry с помощью curl
<img width="1189" height="309" alt="image" src="https://github.com/user-attachments/assets/0b48cb08-1799-491c-a93c-a14b6d42eecf" />
Не успел за 5 минут попасть в Portainer поэтому после проброса порта через ssh на порт 9000 не смог попасть
Выполнил перезапуск контейнера
<img width="1402" height="216" alt="image" src="https://github.com/user-attachments/assets/c0d1fb76-3552-4bd6-aba7-c21bcf084437" />
Далее зашел на вебморду по http://127.0.0.1:9000 задал пароль и нашел токен
<img width="1035" height="607" alt="image" src="https://github.com/user-attachments/assets/7f9e58fb-eefe-453b-86c0-e49eef6bec37" />
Нужен второй токен, первый устарел с прошлого запуска
<img width="987" height="53" alt="image" src="https://github.com/user-attachments/assets/cc26b1e8-a5b2-4102-9872-69c37ee94efd" />
Захожу куда просят http://127.0.0.1:9000/#!/3/docker/stacks

<img width="1603" height="293" alt="image" src="https://github.com/user-attachments/assets/bffd01ec-bd55-41e6-9539-26d8037ea40d" />
Делаю то что просят

<img width="1574" height="602" alt="image" src="https://github.com/user-attachments/assets/16f848ba-dd87-4402-8ba6-db77cb430383" />
Делаю то что просят

<img width="1606" height="384" alt="image" src="https://github.com/user-attachments/assets/140f1285-7709-4cb3-9d5c-7f68a991ad0e" />
Делаю то что просят

<img width="1198" height="686" alt="image" src="https://github.com/user-attachments/assets/0dbd1ab1-35f9-4cbd-b21e-9a6fa4b9b261" />
Делаю то что просят

<img width="662" height="843" alt="image" src="https://github.com/user-attachments/assets/462be22d-3644-42d9-9ce8-016110f243b1" />

Финальное задание. Я удалил файл compose.yaml и перезапустил проект , пришло уведомление от Docker Compose, что он обнаружил контейнеры Сироты.
В проекте task-5 по факту запущено 2 контейнера а новый перезапуск показывает что запустить нужно всего один
Для Compose источник правды всегда файл .yaml поэтому он мне предложил удалить контейнер сироту
<img width="1638" height="600" alt="image" src="https://github.com/user-attachments/assets/2e45c222-c9a7-4a35-ba2e-605e0b7a3eaa" />

### Шаги выполнения:
<details>
  <summary>Нажмите, чтобы открыть</summary>
  
* Создаю папку и запрашиваемые файлы
```
~# mkdir -p /tmp/netology/docker/task5/
~# vim /tmp/netology/docker/task5/compose.yaml
~# vim /tmp/netology/docker/task5/docker-compose.yaml
~# cd /tmp/netology/docker/task5/
~# docker compose up -d
```
* Проверяю что запустилось
```
~# docker compose ps
WARN[0000] Found multiple config files with supported names: /tmp/netology/docker/task5/compose.yaml, /tmp/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /tmp/netology/docker/task5/compose.yaml
WARN[0000] /tmp/netology/docker/task5/compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
NAME                IMAGE                           COMMAND        SERVICE     CREATED          STATUS          PORTS
task5-portainer-1   portainer/portainer-ce:latest   "/portainer"   portainer   35 seconds ago   Up 32 seconds
```
* Делаю include в файле compose.yaml файла docker-compose.yaml и делаю запуск
```
~# vim /tmp/netology/docker/task5/compose.yaml 
~# docker compose up -d
```
* Проверяю запуск контейнеров
```
~# docker compose ps
WARN[0000] Found multiple config files with supported names: /tmp/netology/docker/task5/compose.yaml, /tmp/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /tmp/netology/docker/task5/compose.yaml
WARN[0000] /tmp/netology/docker/task5/docker-compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
WARN[0000] /tmp/netology/docker/task5/compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
NAME                IMAGE                           COMMAND                  SERVICE     CREATED          STATUS          PORTS
task5-portainer-1   portainer/portainer-ce:latest   "/portainer"             portainer   14 minutes ago   Up 14 minutes
task5-registry-1    registry:2                      "/entrypoint.sh /etc…"   registry    3 minutes ago    Up 3 minutes    0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp
```
* Создаю тег на старый образ из заданий и проверяю что он создан
```
~# docker tag legend1demp9/custom-nginx:1.0.0 127.0.0.1:5000/custom-nginx:latest
~# docker images | grep custom-nginx
127.0.0.1:5000/custom-nginx:latest   2332bee6f9ff        279MB         72.2MB
docker-hub-login/custom-nginx:1.0.0      2332bee6f9ff        279MB         72.2MB
```
* Загружаю образ в свой локальный Registry, проверяю загрузку
```
~# docker push 127.0.0.1:5000/custom-nginx:latest
~# curl -s http://localhost:5000/v2/_catalog
{"repositories":["custom-nginx"]}
```
* Перезапустил Compose
```
~# docker compose ls
NAME                STATUS              CONFIG FILES
task5               running(2)          /tmp/netology/docker/task5/compose.yaml

~#  docker compose restart portainer
WARN[0000] Found multiple config files with supported names: /tmp/netology/docker/task5/compose.yaml, /tmp/netology/docker/task5/docker-compose.yaml
WARN[0000] Using /tmp/netology/docker/task5/compose.yaml
WARN[0000] /tmp/netology/docker/task5/docker-compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
WARN[0000] /tmp/netology/docker/task5/compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] restart 0/1
 ⠹ Container task5-portainer-1 Restarting                                                                                                                                                               0.2s
 
~# docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS              PORTS                                         NAMES
be5403098327   registry:2                      "/entrypoint.sh /etc…"   45 minutes ago   Up 45 minutes       0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp   task5-registry-1
90c99d5e93ba   portainer/portainer-ce:latest   "/portainer"             56 minutes ago   Up About a minute                                                 task5-portainer-1
```
* Пробросил порт 9000 через ssh
```
ssh -L 9000:localhost:9000 ubuntu@8.8.8.8 
```
* Зашел в web морду и настроил учетную запись
* Нашел setup_токен
```
~# docker logs task5-portainer-1 2>&1 | grep setup_token
```
* Делаю в веб морде то что просят
* Удаляю файл compose.yaml
```
~# mv compose.yaml /root/compose.yaml_temp
```
* Перезапускаю Compose
```
~# docker compose up -d
WARN[0000] Found orphan containers (task5-portainer-1) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
[+] up 1/1
 ✔ Container task5-registry-1 Running
```
* Удаляю контейнер-сироту
```
~# docker compose up -d --remove-orphans
[+] up 2/2
 ✔ Container task5-registry-1  Running                                                                                                                                                                  0.0s
 ✔ Container task5-portainer-1 Removed
```
* Выключаю проект 
```
~# docker compose down
[+] down 2/2
 ✔ Container task5-registry-1 Removed                                                                                                                                                                   0.1s
 ✔ Network task5_default      Removed
```
</details>
