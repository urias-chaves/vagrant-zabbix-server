#!/bin/bash

# Autor: Urias Chaves
# Data de Criação: Agosto de 2023
# Script criado para ser executado apenas um vez!

#Acessando o repositório do zabbix para baixar o pacote .deb
#Descompactando e atualizando o S.O
echo "Iniciando o Download e Descompactando o arquivo .deb"
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
sudo apt update

sleep 3
echo "Continuando..."
#######################################FIM##################################################
echo "Realizando a Instalação do Zabbix com as Respectivas Dependências"
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sleep 3
echo "Continuando..."
#######################################FIM##################################################
echo "Instalando o Mysql"
sudo apt-get install -y mysql-server

sleep 3
echo "Continuando..."
#######################################FIM##################################################
echo "Acessando o Mysql para criar o BD com Usuário Zabbix"
sudo mysql -uroot
sudo mysql -uroot -e "create database zabbix character set utf8mb4 collate utf8mb4_bin"
sudo mysql -uroot -e "create user zabbix@localhost identified by 'password'"
sudo mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost"
sudo mysql -uroot -e "set global log_bin_trust_function_creators = 1"
sudo mysql -uroot -e "quit"

sleep 3
echo "Continuando..."
#######################################FIM##################################################
echo "Importando o BD"
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix
sudo mysql -uroot -e "set global log_bin_trust_function_creators = 0"

sleep 3
echo "Continuando..."
#######################################FIM##################################################
echo "Configurando o banco de dados para o servidor Zabbix"
echo -e 'DBPassword=password' >> /etc/zabbix/zabbix_server.conf
sleep 3

echo "Continuando..."
#######################################FIM##################################################
echo "Acessando o arquivo locale.gen para inserir a opção de idioma".
echo 'pt_BR ISO-8859-1' >> /etc/locale.gen
echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen
sudo locale-gen

sleep 3

echo "Continuando..."
#######################################FIM##################################################
echo "Reiniciando e Ativando os Serviços do Zabbix"
sudo systemctl enable zabbix-server
sudo /lib/systemd/systemd-sysv-install enable zabbix-server 

sudo systemctl enable zabbix-agent
sudo /lib/systemd/systemd-sysv-install enable zabbix-agent 

sudo systemctl enable apache2
sudo /lib/systemd/systemd-sysv-install enable apache2
sleep 3
  
sudo systemctl restart zabbix-server zabbix-agent apache2
sleep 3

sudo systemctl status zabbix-server.service zabbix-agent.service apache2.service
#######################################FIM##################################################