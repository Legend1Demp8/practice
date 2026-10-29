## Задание 0
Привет, очень информативно, спасибо, прочитал

## Задание 1
### Решение
Основные ошибки
1) Объявлены переменные которые не используются
2) Версии провайдеров не закреплены
3) Версии гит репозитория Udjin ссылается на актуальную ветку master и не закреплена
### Как делал
<details>
  <summary>Как делал</summary>

#### tflint на папку src для урока 04
docker run --rm -v /root/netology/super_temp/ter-homeworks/04/src/:/data -t ghcr.io/terraform-linters/tflint --recursive
1)  Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)
Не зафиксирована версия провайдера

Следующие ошибки говорят про то что объявлены переменные которые не используются
```
Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used
Warning: [Fixable] variable "vm_web_name" is declared but not used
Warning: [Fixable] variable "vm_db_name" is declared but not used
```
<img width="1224" height="555" alt="image" src="https://github.com/user-attachments/assets/46bf3753-3bff-42eb-9eb4-6aeac543ded9" />

#### tflint на папку demonstration1 для урока 04
docker run --rm -v /root/netology/super_temp/ter-homeworks/04/demonstration1/:/data -t ghcr.io/terraform-linters/tflint --recursive
1) Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)
Отсутствие фиксации версии провайдера
2) Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)
Сканер требует, чтобы внешние зависимости были зафиксированы с помощью версионного тега (например, ?ref=v1.2.0), а не просто имени ветки ?ref=main
3) Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)
Сканер требует, чтобы внешние зависимости были зафиксированы с помощью версионного тега (например, ?ref=v1.2.0), а не просто имени ветки ?ref=main
4) Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)
Отсутствие фиксации версии провайдера
5) Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)
Отсутствие фиксации версии провайдера
6) variable "public_key" is declared but not used (terraform_unused_declarations)
Ошибка говорит про то что объявлена переменная которая не используются
<img width="923" height="471" alt="image" src="https://github.com/user-attachments/assets/9992578b-4323-4b46-9037-2e0e15a533c0" />

#### checkov на папку src для урока 04
docker run --rm -v /root/netology/super_temp/ter-homeworks/04/src/:/tf bridgecrew/checkov -d /tf --framework terraform --skip-download
1) Ошибок нет
<img width="1310" height="137" alt="image" src="https://github.com/user-attachments/assets/86d53063-9e7f-440e-a262-76117150e7d8" />

#### checkov на папку demonstration1 для урока 04
docker run --rm -v /root/netology/super_temp/ter-homeworks/04/demonstration1/:/tf bridgecrew/checkov -d /tf --framework terraform --skip-download
1) Ensure Terraform module sources use a commit hash
Сканер безопасности сообщает, что привязываться к именам веток (например, main, master, dev) небезопасно
2) Ensure Terraform module sources use a tag with a version number
Сканер требует, чтобы внешние зависимости были зафиксированы с помощью версионного тега (например, ?ref=v1.2.0), а не просто имени ветки ?ref=main
3) Ensure Terraform module sources use a commit hash
Сканер безопасности сообщает, что привязываться к именам веток (например, main, master, dev) небезопасно
4) Ensure Terraform module sources use a tag with a version number
Сканер требует, чтобы внешние зависимости были зафиксированы с помощью версионного тега (например, ?ref=v1.2.0), а не просто имени ветки ?ref=main

<img width="1514" height="164" alt="image" src="https://github.com/user-attachments/assets/52a05cfe-f9b9-4724-8f23-eb186663819f" />
<img width="577" height="878" alt="image" src="https://github.com/user-attachments/assets/f82dc7c4-0bde-4f97-9915-b83ed8486747" />

</details>
