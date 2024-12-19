#!/bin/bash

# update
echo updating packages...
sudo apt update -y
echo done updating!

# upgrade
echo upgrading packages...
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo done upgrading!

# 1. From a terminal, install gnupg and curl
sudo apt-get install gnupg curl

# 2. To import the MongoDB public GPG key
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
  gpg --dearmor | \
  sudo install -D -m 644 /dev/stdin /usr/share/keyrings/mongodb-server-7.0.gpg

# 3. Create the list file
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# 4. Reload the package database.
sudo apt-get update -y

# 5. Install MongoDB Community Server. Change version from 7.0.14 to 7.0.6
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

# 6. Optionally, to prevent accidental upgrade, run the following
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# restart mongod
sudo systemctl start mongod

# To ensure that MongoDB will start following a system reboot
sudo systemctl enable mongod

# Modify configuration file
sudo sed -i 's/^  bindIp: 127\.0\.0\.1/  bindIp: 0.0.0.0/' /etc/mongod.conf

# enable mongod
sudo systemctl restart mongod
