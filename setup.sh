#!/bin/bash

# Update package lists
sudo apt-get update

# Install Apache web server
sudo apt-get install apache2 -y

# Enable mod_wsgi
sudo apt-get install libapache2-mod-wsgi-py3 -y
sudo a2enmod wsgi

# Install Python and pip
sudo apt-get install python3 python3-pip -y

# Install Flask and other dependencies
pip3 install flask mysql-connector-python

# Create a symbolic link to the Flask app directory in /var/www/
sudo ln -s /home/sysadmin/Desktop/UB-Bank-main /var/www/flask-app

# Set appropriate permissions to the Flask app directory
sudo chown -R www-data:www-data /var/www/flask-app

# Create server.wsgi file
cat <<EOF | sudo tee /var/www/flask-app/server.wsgi
#!/usr/bin/python3
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0, "/var/www/flask-app")

from server import app as application
EOF

# Set permissions for the WSGI file
sudo chmod 664 /var/www/flask-app/server.wsgi

# Configure Apache virtual host for Flask app
sudo touch /etc/apache2/sites-available/flask-app.conf

# Write Apache virtual host configuration
cat <<EOF | sudo tee /etc/apache2/sites-available/flask-app.conf
<VirtualHost *:80>
    ServerName localhost

    WSGIDaemonProcess your_project_name user=www-data group=www-data threads=5
    WSGIScriptAlias / /var/www/flask-app/server.wsgi

    <Directory /var/www/flask-app>
        WSGIProcessGroup your_project_name
        WSGIApplicationGroup %{GLOBAL}
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable the virtual host
sudo a2ensite flask-app

# Restart Apache server
sudo systemctl restart apache2

echo "Flask app deployed successfully!"
