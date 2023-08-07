Criar máquina virtual no vagrant, em seguida instalar o serviço do Zabbix Server

Criar script para: Instalar o mysql, Instalar o zabbix-server.
Subir os arquivos para um repositório no Github com o nome "vagrant-zabbix-server​".

- Download do espelho da imagem para gerar o arquivo Vagrantfile, onde constará as configurações da MV.
https://app.vagrantup.com/ubuntu/boxes/focal64

  - Nome da MV
  - Tipo de rede (public_network)
  - Especificação das portas (forwarded_port) usadas para comunicação entre o guest = MV com o host.

- Neste cenário foram usadas as portas 10051 na MV comunicando com a porta 80 da máquina real.


- shellscritp "zabbix.sh" foi criado de forma simples usando apenas comandos do Linux e os passos especificados na documentação do zabbix.
 https://www.zabbix.com/download?zabbix=6.4&os_distribution=ubuntu&os_version=20.04&components=server_frontend_agent&db=mysql&ws=apache

- Após a conclusão do Script "zabbix.sh" abrir o navegador e digitar o IP/zabbix.
- inserir usuário:Admin e senha:zabbix para finalizar a configuração.
