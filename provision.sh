

# Actualizar los paquetes e instalar OpenJDK
sudo apt update
sudo apt upgrade 
sudo apt install -y openjdk-11-jdk

# Instalar Tomcat 9
sudo apt install -y tomcat9

# Crear un grupo de usuarios para Tomcat 9
sudo groupadd tomcat9

# Crear un usuario para Tomcat 9
sudo useradd -s /bin/false -g tomcat9 -d /etc/tomcat9 tomcat9

# Arrancar el servicio de Tomcat 9
sudo systemctl start tomcat9

# Definir un usuario con acceso a Tomcat
sudo cp /vagrant/tomcat-users.xml /etc/tomcat9/

# Instalar el administrador web y el administrador de host de Tomcat
sudo apt install -y tomcat9-admin

# Sustituir el fichero context.xml para permitir acceso remoto
sudo cp /vagrant/context.xml /usr/share/tomcat9-admin/host-manager/META-INF/

# Recargar el servidor Tomcat
sudo systemctl restart tomcat9

# Instalar Maven
sudo apt-get update && sudo apt-get -y install maven

# Copiar el archivo settings.xml para configurar Maven
sudo cp /vagrant/settings.xml /etc/maven/

# Clonar el repositorio de la aplicación
git clone https://github.com/cameronmcnz/rock-paper-scissors.git /home/vagrant/rock-paper-scissors

# Cambiar al directorio del proyecto clonado
cd /home/vagrant/rock-paper-scissors

# Cambiar de rama
git checkout patch-1

# Actualizar el pom.xml para añadir el plugin de Tomcat con Maven
sed -i '/<\/plugins>/i \
<plugin>\
  <groupId>org.apache.tomcat.maven</groupId>\
  <artifactId>tomcat7-maven-plugin</artifactId>\
  <version>2.2</version>\
  <configuration>\
    <url>http://localhost:8080/manager/text</url>\
    <server>Tomcat</server>\
    <path>/rock-paper-scissors</path>\
  </configuration>\
</plugin>' pom.xml

# Generar el archivo WAR
mvn clean package

# Desplegar la aplicación en Tomcat
mvn tomcat7:deploy