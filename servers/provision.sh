#!/usr/bin/env bash

echo "Installing Apache and setting it up..."

# Downloads the latest index of available packages without logging
apt-get clean
apt-get update

# Install apache2 with yes as option to install all packages
apt-get install -y apache2

# Delete the folder where apache serves files
# Create a symbolic link to our vagrant folder (automatically mounted, C:\cygwin64\home\enehme\vagrant)
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

echo "Server is up..."