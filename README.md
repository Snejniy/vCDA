# vCDA Backup

Скрипт служит для создания файлового бекапа VCDA Manager | Replicator | Tunnel каждый день через crond.

Принцип работы:
1. Авторизация в API
2. Создание нового бекапа
3. Удаление бекапа старше 7 дней


Install Guide

1. Установливаем cron в vCDA Manager.
1.1 cd /etc/yum.repos.d/
  1.2 vi photon-release.repo
  1.3 Изменяем 0 на 1 enabled=1, сохраняем файл
  1.4 Устанавливаем cronie - tdnf install cronie
  1.5 systemctl start crond
  1.6 systemctl enable crond
  1.7 vi photon-release.repo
  1.8 Изменяем 1 на 0 enabled=0, сохраняем файл


2. Размещаем скрипт для бекапа.

  2.1 Создаем папку для хранения скрипта - mkdir /home/scripts
  2.2 Копируем туда файлы cloud_backup_vcda.sh и vcda_auth.cfg
  2.3 В файле vcda_auth.cfg изменяем значения для подключения к vCDA
  2.4 cd /home/scripts
  2.5 chmod u+x cloud_backup_vcda.sh
  2.6 chmod 750 vcda_auth.cfg
  2.7 Копируем файл vcda-backup в папку /etc/cron.d
