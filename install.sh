#!/bin/bash

# git
sudo apt-get install git -y
git config --global user.email czasocheci@gmail.com
git config --global user.name czasocheci

_INSTALL_HOME=/home/czasocheci/work
#/work
_JAVA_DIR=$_INSTALL_HOME/java
_WORKSPACE_DIR=$_INSTALL_HOME/workspace
_STS_DIR=$_INSTALL_HOME/sts
_MAVEN_DIR=$_INSTALL_HOME/maven
_TOMCAT_DIR=$_INSTALL_HOME/tomcat
_LOMBOK_DIR=$_INSTALL_HOME/lombok

#java
mkdir $_JAVA_DIR
cd $_JAVA_DIR
wget https://www.dropbox.com/s/alue6vidafgltfj/jdk-7u60-linux-x64.gz
tar -zxf jdk-7u60-linux-x64.gz
ln -s jdk1.7.0_60 jdk

export JAVA_HOME=$_JAVA_DIR/jdk
export PATH=$JAVA_HOME/bin:$PATH

#maven
mkdir $_MAVEN_DIR
cd $_MAVEN_DIR
wget http://ftp.ps.pl/pub/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
tar -zxf apache-maven-3.2.1-bin.tar.gz
ln -s apache-maven-3.2.1 mvn
export M2_HOME=$_MAVEN_DIR/mvn
export PATH=$M2_HOME/bin:$PATH

#tomcat
mkdir $_TOMCAT_DIR
cd $_TOMCAT_DIR
wget https://www.dropbox.com/s/mzmfpky57lap0l0/apache-tomcat-8.0.5.tar.gz
tar -zxf apache-tomcat-8.0.5.tar.gz
ln -s apache-tomcat-8.0.5 tomcat
ln -s tomcat/bin/startup.sh startup.sh
ln -s tomcat/bin/shutdown.sh shutdown.sh
ln -s tomcat/logs/ logs
echo 'tail -500f logs/catalina.out' >tail.sh
chmod +x tail.sh
echo 'ps -ef | grep tomcat' >ps.sh
chmod +x ps.sh

#sts
mkdir $_STS_DIR
cd $_STS_DIR
#TODO add to dropbox
#wget 
tar -zxf spring-tool-suite-3.6.2.RELEASE-e4.4.1-linux-gtk-x86_64.tar.gz
ln -s sts-bundle/sts-3.6.2.RELEASE/STS STS

#lombok
mkdir $_LOMBOK_DIR
cd $_LOMBOK_DIR
wget https://www.dropbox.com/s/u1pmml17dmhduzd/lombok-1.14.8.jar
java -jar lombok-1.14.8.jar install $_STS_DIR/sts-bundle/sts-3.6.2.RELEASE/

#postgres
sudo apt-get install postgresql-9.3 -y
sudo su - postgres
psql
create user dbuser with password 'dbpass';
CREATE DATABASE dbname OWNER dbuser;
\q
exit


#env
cd $_INSTALL_HOME
_ENV_FILE=_work.sh
touch $_ENV_FILE
chmod +x $_ENV_FILE
JAVA_HOME=$_JAVA_DIR/jdk
M2_HOME=$_MAVEN_DIR/mvn
PATH=$JAVA_HOME/bin:$PATH
PATH=$M2_HOME/bin:$PATH
echo "export JAVA_HOME=$JAVA_HOME" >> $_ENV_FILE
echo "export M2_HOME=$M2_HOME" >> $_ENV_FILE
echo "export PATH=$PATH" >> $_ENV_FILE
source _work.sh
