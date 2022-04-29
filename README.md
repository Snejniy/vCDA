# vCDA Backup

Скрипт служит для создания файлового бекапа VCDA Manager | Replicator | Tunnel каждый день через crond.

Принцип работы:
1. Авторизация в API
2. Создание нового бекапа
3. Удаление бекапа старше 7 дней


Install Guide

1. Установливаем cron в vCDA Manager.
  - cd /etc/yum.repos.d/.
  - vi photon-release.repo
  - Изменяем 0 на 1 enabled=1, сохраняем файл
  - Устанавливаем cronie - tdnf install cronie
  - systemctl start crond
  - systemctl enable crond
  - vi photon-release.repo
  - Изменяем 1 на 0 enabled=0, сохраняем файл


2. Размещаем скрипт для бекапа.

  - Создаем папку для хранения скрипта - mkdir /home/scripts
  - Копируем туда файлы cloud_backup_vcda.sh и vcda_auth.cfg
  - В файле vcda_auth.cfg изменяем значения для подключения к vCDA
  - cd /home/scripts
  - chmod u+x cloud_backup_vcda.sh
  - chmod 750 vcda_auth.cfg
  - Копируем файл vcda-backup в папку /etc/cron.d
