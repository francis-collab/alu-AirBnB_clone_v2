#!/usr/bin/env bash
# Sets up web servers for the deployment of web_static.

# Install Nginx if not installed
sudo apt-get update -y
sudo apt-get install -y nginx

# Create folder structure
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create a fake HTML file
echo "<html>
  <head></head>
  <body>Holberton School</body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set ownership
sudo chown -R ubuntu:ubuntu /data/

# Safely add alias config for /hbnb_static/
CONFIG="/etc/nginx/sites-available/default"
if ! grep -q "location /hbnb_static/" "$CONFIG"; then
    sudo sed -i "/server_name _;/a \\\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t\tindex index.html;\n\t}" "$CONFIG"
fi

# Restart Nginx
sudo service nginx restart
