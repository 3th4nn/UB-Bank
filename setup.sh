#!/bin/bash

# Install Apache and mod_wsgi
sudo apt-get update
sudo apt-get install apache2 libapache2-mod-wsgi-py3 -y

# Install Python dependencies
sudo apt-get install python3-pip -y
sudo pip3 install flask mysql-connector-python

# Create a directory for the Flask app
sudo mkdir /var/www/flaskapp

# Copy Flask app files
sudo cp -r /path/to/your/flaskapp/* /var/www/flaskapp

# Create Apache site configuration file
sudo tee /etc/apache2/sites-available/flaskapp.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName localhost

    WSGIDaemonProcess flaskapp user=www-data group=www-data threads=5
    WSGIScriptAlias / /var/www/flaskapp/app.wsgi

    <Directory /var/www/flaskapp>
        WSGIProcessGroup flaskapp
        WSGIApplicationGroup %{GLOBAL}
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable the site and WSGI module
sudo a2ensite flaskapp.conf
sudo a2enmod wsgi

# Restart Apache
sudo systemctl restart apache2
