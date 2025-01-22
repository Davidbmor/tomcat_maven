#Instalaremos el kit de desarrollo de java:
sudo apt update
sudo apt upgrade 
sudo apt install -y openjdk-11-jdk


#Instalaremos el kit de desarrollo de java:
sudo apt install -y tomcat9

#Crearemos un grupo de usuarios para tomcat9
sudo groupadd tomcat9

# Crearemos un usuario para el servicio
sudo useradd -s /bin/false -g tomcat9 -d /etc/tomcat9 tomcat9


sudo systemctl start tomcat9


#Copiamos tomcat-users.xml con la configuracion 

sudo cp /vagrant/tomcat-users.xml /etc/tomcat9/tomcat-users.xml

#Ahora, instalemos el administrador web y el administrador de host de Tomcat ejecutando el siguiente comando
sudo apt install -y tomcat9-admin

#Copiamos el archivo context.xml
sudo cp /vagrant/context.xml /usr/share/tomcat9-admin/host-manager/META-INF/


sudo systemctl restart tomcat9


#Descargamos maven 
sudo apt-get update 
sudo apt-get -y install maven

#Añadimos un usuario

#Copiamos el archivo settings de maven 
sudo cp /vagrant/settings.xml  /etc/maven/settings.xml

#Creamos una carmeta para la aplicacion
sudo mkdir app

#Desplegamos la palicacion
sudo mvn archetype:generate -e -DgroupId=org.zaidinvergeles -DartifactId=tomcat-war -DarchetypeArtifactId=maven-archetype-webapp  -DinteractiveMode=false

#Damos permisos a la carpeta 
sudo chown -R vagrant:vagrant /home/vagrant/app/tomcat-war

sudo cp /vagrant/pom.xml  app/tomcat-war/pom.xml