## Доработка
## 1) В задании 2.4 сказано заменить ресурсы yandex_vpc_network и yandex_vpc_subnet модулем, а старые develop, develop_1 и develop_2 остались в main.tf и создаются впустую;
### Решение
Изменен Файл [main.tf](https://github.com/Legend1Demp8/terraform-04/blob/terraform-04/main.tf)

## 2) Модуль должен возвращать информацию о yandex_vpc_subnet, а у вас наружу отдаются только два id. Отдайте объект подсети целиком;
### Решение
Изменен Файл [modules/vpc/outputs.tf](https://github.com/Legend1Demp8/terraform-04/blob/terraform-04/modules/vpc/outputs.tf)

## 3) В задании прямо сказано «хардкод значения не допустимы», а в вызовах модулей зоны, cidr, platform и image_family прописаны строками;
### Решение
Изменен Файл [main.tf](https://github.com/Legend1Demp8/terraform-04/blob/terraform-04/main.tf) \
Изменен Файл [variables.tf](https://github.com/Legend1Demp8/terraform-04/blob/terraform-04/variables.tf)

## 4) Remote-модуль лучше пинить по тегу или коммиту, а не ref=main;
### Решение
Изменен Файл [main.tf](https://github.com/Legend1Demp8/terraform-04/blob/terraform-04/main.tf)

## 5) По правилам приёма нужна ветка terraform-04, а код лежит в main.
### Решение
[github](https://github.com/Legend1Demp8/terraform-04/tree/terraform-04)


## Задание 1
### Решение:
<img width="1723" height="282" alt="image" src="https://github.com/user-attachments/assets/6032357b-fa41-4b3c-a4d3-126845a7896d" />
<img width="1019" height="550" alt="image" src="https://github.com/user-attachments/assets/4ed47d0f-c680-4bbf-a5a5-828fd8bc03cd" />
Не поместить все это в один экран > module.vm_analytics , если нужно скажите пришлю всю портянку
<img width="489" height="877" alt="image" src="https://github.com/user-attachments/assets/47d53178-141a-4fd8-a51d-786afab6f45f" />


## Задание 2
### Решение:
Модуль \
<img width="365" height="107" alt="image" src="https://github.com/user-attachments/assets/db8119c8-0930-4b4d-aff2-e6c1d91d5dea" />
Применяем сеть из модуля на две вм \
<img width="730" height="560" alt="image" src="https://github.com/user-attachments/assets/5a999ff8-1325-40bd-af07-0b6763522b64" />
<img width="1736" height="416" alt="image" src="https://github.com/user-attachments/assets/e99e719e-fcc3-4fae-aee3-11eeb4cd1ad4" />
Terraform-docs \
<img width="1167" height="190" alt="image" src="https://github.com/user-attachments/assets/58117f48-8752-49c9-a527-426d71c0888b" />

## Задание 3
### Решение:
Выведите список ресурсов в стейте. \
<img width="665" height="218" alt="image" src="https://github.com/user-attachments/assets/16ae7894-d3d5-4ea0-910b-600f2e511679" />
Полностью удалите из стейта модуль vpc. \ 
<img width="879" height="108" alt="image" src="https://github.com/user-attachments/assets/c309462f-3152-420d-9e6e-a351f1341106" />
Полностью удалите из стейта модуль vm. \
<img width="1231" height="241" alt="image" src="https://github.com/user-attachments/assets/5e37d16c-12d0-4cf3-b9e9-9756f1e6c57c" />
Результат удаления \
<img width="698" height="132" alt="image" src="https://github.com/user-attachments/assets/fa985b9e-4100-4fa5-a370-4327188d5f94" />

Восстановление
```
Сеть
terraform import module.marketing_vpc.yandex_vpc_network.this enpnbh8aeks4rh7t1lb1

Подсеть
terraform import module.marketing_vpc.yandex_vpc_subnet.this fl8tn98rtl8146qgutch

Первая вм
terraform import 'module.vm_analytics.yandex_compute_instance.vm[0]' fv4v2l5akbnkpldrmdud

Вторая вм
terraform import 'module.vm_marketing.yandex_compute_instance.vm[0]' fv4tck93m551c0kfg4qv
```
Скриншот восстановления \
Сеть \
<img width="1279" height="505" alt="image" src="https://github.com/user-attachments/assets/f9636155-9741-4112-945b-08b40e3bc28c" />
Подсеть \
<img width="1274" height="504" alt="image" src="https://github.com/user-attachments/assets/20fe529a-8ee5-4892-9d54-166819229f24" />
Одна вм (вторая такаяже не стал тратить место) \
<img width="1086" height="402" alt="image" src="https://github.com/user-attachments/assets/1b7a987b-cce5-40bb-8bf5-c9efe76a7e87" />

Terraform plan показывает не значимое изменение
<img width="854" height="370" alt="image" src="https://github.com/user-attachments/assets/1a246fd7-cf9e-4e7c-805d-fd4cdf81e0ae" />

## Github
[github](https://github.com/Legend1Demp8/terraform-04)


