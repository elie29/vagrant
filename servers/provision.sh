#!/usr/bin/env bash

echo "Installing Apache and setting it up..."

# Downloads the latest index of available packages without logging
apt-get clean
apt-get update

# Install apache2 with yes as option to install all packages
apt-get install -y apache2

# Install git
apt-get install -y --force-yes git

# Delete the folder where apache serves files
# Create a symbolic link to our vagrant folder (automatically mounted, cygwin64\home\user\servers)
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Append ServerName to apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Remove optional virtual hosts
rm -f /etc/apache2/sites-enabled/000-default.conf

# Restart apache
service apache2 restart

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

echo "Web server is up..."