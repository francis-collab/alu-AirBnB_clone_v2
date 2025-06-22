#!/usr/bin/env bash
# Sets up web servers for the deployment of web_static.

# Install Nginx if not already installed
sudo apt-get update -y
sudo apt-get install -y nginx

# Create required directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create simple HTML file
echo "<html>
  <head></head>
  <body>Holberton School</body>
</html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Remove rogue test files if any
sudo find /data/web_static/releases/test/ -type f ! -name index.html -delete

# Recreate symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set correct ownership
sudo chown -R ubuntu:ubuntu /data/

# Define Nginx config path
CONFIG="/etc/nginx/sites-available/default"

# Insert alias config only if not present
if ! grep -q "location /hbnb_static/" "$CONFIG"; then
    sudo sed -i "/server_name _;/a \\\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t\tindex index.html;\n\t}" "$CONFIG"
fi

# Check and reload Nginx
sudo nginx -t && sudo service nginx reload

