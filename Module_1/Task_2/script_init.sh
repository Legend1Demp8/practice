#!/bin/bash

echo "=== Настройка окружения для Packer ==="

read -p "Введите путь к вашему JSON-ключу (например, ./key.json): " YC_KEY_FILE

if [ -z "$YC_KEY_FILE" ]; then
    echo "Ошибка: Ключ не может быть пустым!"
    exit 1
fi

# 2. Запрашиваем Folder ID
read -p "Введите ваш yc_folder_id: " YC_FOLDER_ID

# Проверка Folder ID
if [ -z "$YC_FOLDER_ID" ]; then
    echo "Ошибка: Переменная yc_folder_id не может быть пустой!"
    exit 1
fi

# Экспортируем проверенные переменные в окружение
export YC_KEY_FILE
export YC_FOLDER_ID
export CHECKPOINT_DISABLE=1
#export PACKER_LOG=1
#export PACKER_HTTP_DEBUG=1
#export PACKER_LOG_PATH="/root/packer_http.log"
#PACKER_LOG_LEVEL=DEBUG

echo "----------------------------------------"
echo "Переменные инициализированы."
echo "----------------------------------------"

# Меню выбора формата файла
echo "Выберите формат конфигурационного файла для Packer:"
echo "1) Запустить с JSON (ubuntu-2604-docker.json)"
echo "2) Запустить с HCL (ubuntu-2604-docker.pkr.hcl)"
read -p "Введите номер варианта (1 или 2): " FILE_CHOICE

case "$FILE_CHOICE" in
    1)
        TARGET_FILE="ubuntu-2604-docker.json"
        ;;
    2)
        TARGET_FILE="ubuntu-2604-docker.pkr.hcl"
        ;;
    *)
        echo "Ошибка: Неверный выбор! Допустимы только варианты 1 или 2."
        exit 1
        ;;
esac

# Запуск Packer с вашим файлом конфигурации
packer build -var "service_account_key_file=$YC_KEY_FILE" -var "yc_folder_id=$YC_FOLDER_ID" ./${TARGET_FILE}
