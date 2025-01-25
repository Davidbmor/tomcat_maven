# Proyecto Tomcat Maven
Esta práctica consiste en realizar la instalación del servidor de aplicaciones Tomcat 9, en una máquina virtual corriendo Debian 11 Bullseye. Para ello realizaremos:
- Instalación de OpenJDK.
- Instalación de Tomcat 9

## Instalación
Instalaremos el kit de desarrollo de java:
```bash
sudo apt install -y openjdk-11-jdk
```
 Instalaremos el servidor de aplicaciones Tomcat y realizaremos las siguientes tareas:

```bash
 sudo apt install -y tomcat9
```
 Crearemos un grupo de usuarios para tomcat9
```bash
sudo groupadd tomcat9
```
 Crearemos un usuario para tomcat9
```bash
sudo useradd -s /bin/false -g tomcat9 -d /etc/tomcat9 tomcat9
```

![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20165708.jpg)

Arrancamos el servicio de tomcat9
```bash
sudo systemctl start tomcat9
```
Accederemos al servicio en http://localhost:8080
![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20165859.jpg)

## Usuarios y permisos
Definimos un usuario con acceso a Tomcat por medio del siguiente archivo:
```bash
sudo cp /vagrant/tomcat-users.xml /etc/tomcat9/
```

## Instalación del administrador web

Ahora, instalemos el administrador web y el administrador de host de Tomcat ejecutando el siguiente comando:
```bash
sudo apt install -y tomcat9-admin
```


## Acceso a los paneles de administración
 Accede a http://localhost:8080/manager/html e introduce el nombre de usuario y la contraseña 

 ![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20173209.jpg)

 ![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20173611.jpg)

 ##  Acceso remoto
Sustituiremos el fichero `context.xml` del directorio `/usr/share/tomcat9-admin/host-manager/META-INF/` por el siguiente:
```bash
sudo cp /vagrant/context.xml /usr/share/tomcat9-admin/host-manager/META-INF/
```
Recargaremos el servidor:
```bash
sudo systemctl restart tomcat9
```
## Instalación de Maven
```bash
 sudo apt-get update && sudo apt-get -y install maven
```
Comprobamos la versión de Maven
```bash
mvn -version
```

## settings.xml
Edita el archivo /etc/maven/settings.xml para indicarle a Maven, un identificador para el servidor sobre
el que vamos a desplegar
```bash
sudo cp /vagrant/settings.xml /etc/maven/
```

## Generar una aplicacion 

Clonamos el repositorio
```bash
 git clone https://github.com/cameronmcnz/rock-paper-scissors.git
```
Nos situamos dentro de el directorio clonado
```bash
cd rock-paper-scissors
```
Cambiamos de rama
```bash
 git checkout patch-1
```
Actualizamos el pom.xml para añadir el plugin de tomcat con maven
```xml
<plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.2</version>
        <configuration>
          <url>http://localhost:8080/manager/text</url>
          <server>Tomcat</server>
          <path>/rock-paper-scissors</path>
        </configuration>
</plugin>
```

## Copiamos la aplicacion en la maquina virtual
```bash
sudo mkdir /home/vagrant/rock-paper-scissors
```
```bash
sudo cp -r /vagrant/rock-paper-scissors /home/vagrant/rock-paper-scissors
```

Nos situamos dentro de el directorio clonado
```bash
cd /home/vagrant/rock-paper-scissors
```
Generamos el war
```bash
mvn clean package
```
Por ultimo desplegamos la aplicacion
```bash
mvn tomcat7:deploy
```
![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20181312.jpg)

![Captura de Pantalla](./img/Captura%20de%20pantalla%202025-01-25%20181425.jpg)


