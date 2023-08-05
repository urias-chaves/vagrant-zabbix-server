#!/bin/bash

# # echo "INICIANDO O DOWNLOAD DO MYSQL, GNUPG E DESCOMPACTANDO O ARQUIVO .DEB DO MYSQL"
# sudo wget http://repo.mysql.com/mysql-apt-config_0.8.26-1_all.deb
# sudo dpkg -i mysql-apt-config_0.8.26-1_all.deb
# sudo apt update
# sudo apt install -y gnupg
# # sudo apt-get -f install
# # sudo apt update
# # sudo apt-get install -y mysql-server
# # sudo apt install -y nginx
# #####################################FIM#################################################

# #Acessando o repositório do zabbix para baixar o pacote .deb
# #Descompactando via e atualizando o S.O
echo "INICIANDO O DOWNLOAD DO ZABBIX"
wget https://repo.zabbix.com/zabbix/6.4/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb

sudo dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
apt update
#######################################FIM##################################################

echo "REALIZANDO A INSTALAÇÃO DO ZABBIX E MYSQL"
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

#####################################FIM###################################################

echo "ACESSANDO O MYSQL PARA CRIAR O BD QUE SERÁ USANDO PELO ZABBIX"
mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

##################################FIM#######################################################

echo "IMPORTANDO OS DADOS DO MYSQL"
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

#################################FIM#######################################################

echo "DESATIVANDO O FUNÇÃO log_bin_trust_function_creators"
mysql -uroot -p
password
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;

#############################FIM##########################################################
echo " INSERINDO OS DADOS DO BD NO ZABBIX"
echo DBPassword=password > /etc/zabbix/zabbix_server.conf

#############################FIM##########################################################
echo "LIBERANDO A PORTA PARA ACESSO REMOTO E DEFININDO O NOME DO SERVIDOR"
echo listen 8080; server_name SERVIDOR_ZABBIX > /etc/zabbix/nginx.conf

echo "REINICIANDO E ATIVANDO OS SERVIÇOS DO ZABBIX E MYSQL"
systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm

echo "SCRIPT FINALIZADO"
