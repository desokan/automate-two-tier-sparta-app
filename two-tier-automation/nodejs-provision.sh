#!/bin/bash

# update
sudo apt-get update -y

# upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# install nginx
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y

# create reverse proxy
echo creating reverse proxy...
sudo sed -i 's|try_files.*;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
echo done creating reverse proxy! ...

# download node.js and install
echo downloading nodejs! ...
curl -fsSL https://deb.nodesource.com/setup_20.x -o setup_nodejs.sh
sudo DEBIAN_FRONTEND=noninteractive bash setup_nodejs.sh
sudo DEBIAN_FRONTEND=noninteractive apt-get install nodejs -y
echo done downloading nodejs! ...

# echo nodejs and npm version numbers
echo nodejs and npm versions...
node -v
npm -v
echo done...

# restart nginx
echo restart nginx ...
sudo systemctl restart nginx
echo done! ...

# enable nginx
echo enable nginx ...
sudo systemctl enable nginx
echo done!

# Clone the app repo
echo cloning app rep ...
git clone https://github.com/desokan/my-sparta-app.git
echo done cloning app rep!

# install pm2 globally
echo installing pm2 ...
sudo npm install -g pm2
echo done installing pm2!

# Change directory
cd /my-sparta-app/app

# Create environment variable using the database ip address - 10.0.3.4
echo creating environment variable...
export DB_HOST=mongodb://10.0.3.4:27017/posts
echo done creating environment variable!

# make environment variable persist through restart
echo 'export DB_HOST=mongodb://10.0.3.4:27017/posts' >> ~/.bashrc

# Confirm environment variable was created
echo confirming environment...
printenv DB_HOST
echo done!

# Install dependencies
echo installing dependencies...
npm install
echo done installing dependencies!

# Stop the app if already running
# idempotency => pm2 stop app.js
echo killing app.js process...
pm2 kill # or pm2 stop all
echo done!

# start node.js app with pm2
echo starting nodejs...
pm2 start app.js
echo done!

# Save the pm2 process list for restart on reboot
sudo pm2 save

# keep pm2 running after system reboot
sudo pm2 startup
