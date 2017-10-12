#!/usr/bin/env bash

echo "Installing mysql server and setting it up..."

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --force-yes mysql-server

#modify my.cnf to change 127.0.0.1 to 0.0.0.0
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

restart mysql

mysql -uroot mysql <<< "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"