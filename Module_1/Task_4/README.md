## Задача 1
### Результат: [https://github.com/Legend1Demp8/shvirtd-example-python](https://github.com/Legend1Demp8/shvirtd-example-python)
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
</details>
