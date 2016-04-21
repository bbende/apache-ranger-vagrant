#!/usr/bin/env bash

# Install a JDK
sudo yum --quiet -y install java-1.8.0-openjdk-devel.x86_64

# Install MySQL/MariaDB
sudo yum --quiet -y install mariadb-server mariadb  mysql-connector-java

# Start DB
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

# Set the DB root password
/usr/bin/mysqladmin -u root password 'password'

# Flush iptables
sudo iptables -F

# Set JAVA_HOME for vagrant user
echo "export JAVA_HOME=/usr/lib/jvm/java" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

# Set JAVA_HOME for root user
sudo su -
echo "export JAVA_HOME=/usr/lib/jvm/java" >> /root/.bashrc

# Setup Ranger
/vagrant/scripts/setup-ranger.sh

# Setup Solr for Ranger
/vagrant/scripts/setup-solr.sh

echo "Starting Ranger Admin..."
ranger-admin start

echo "Done bootstrapping VM!"
exit
