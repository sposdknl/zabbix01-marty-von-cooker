#!/bin/bash

# Aktualizace systému
echo "Updating the system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalace požadovaných nástrojů
echo "Installing necessary tools..."
sudo apt-get install -y wget gnupg2 lsb-release apt-transport-https software-properties-common

# Přidání Zabbix repozitáře
echo "Adding Zabbix repository..."
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-2+debian12_all.deb
sudo dpkg -i zabbix-release_7.0-2+debian12_all.deb
sudo apt-get update -y

# Instalace Zabbix serveru, webového rozhraní a agenta
echo "Installing Zabbix server, frontend, and agent..."
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent2 mariadb-server

# Konfigurace databáze pro Zabbix
echo "Configuring MariaDB for Zabbix..."
sudo systemctl start mariadb
sudo mysql -e "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix_password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Import výchozího schématu databáze
echo "Importing Zabbix database schema..."
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | sudo mysql -u zabbix -pzabbix_password zabbix

# Úprava konfigurace Zabbix serveru
echo "Configuring Zabbix server..."
sudo sed -i 's/^# DBPassword=.*/DBPassword=zabbix_password/' /etc/zabbix/zabbix_server.conf

# Spuštění a povolení služeb
echo "Starting and enabling services..."
sudo systemctl restart zabbix-server zabbix-agent2 apache2
sudo systemctl enable zabbix-server zabbix-agent2 apache2

# Základní ověření
echo "Verifying Zabbix services..."
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent2
sudo systemctl status apache2

echo "Je to srtrašně moc hotový na http://localhost:8080/zabbix"