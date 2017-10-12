#!/usr/bin/env bash

echo "Installing mysql server and setting it up..."

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --force-yes mysql-server

# Install git
apt-get install -y --force-yes git

#modify my.cnf to change 127.0.0.1 to 0.0.0.0
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

restart mysql

mysql -uroot mysql <<< "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"

# ADD to .bashrc
# colors!
echo "" >> /home/vagrant/.bashrc
echo 'red="\[\033[1;317m\]"' >> /home/vagrant/.bashrc
echo 'green="\[\033[1;32m\]"' >> /home/vagrant/.bashrc
echo 'purple="\[\033[1;35m\]"' >> /home/vagrant/.bashrc
echo 'reset="\[\033[0m\]"' >> /home/vagrant/.bashrc

# Change command prompt
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
echo 'export PS1="$purple\u$green\$(__git_ps1)$red \W $reset $ "' >> /home/vagrant/.bashrc

echo "DB server is up..."