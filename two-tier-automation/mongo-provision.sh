#!/bin/bash

# Step 1: Update the package database
echo "Updating package database..."
sudo apt update -y
echo "Package database updated!"

# Step 2: Upgrade installed packages
echo "Upgrading installed packages..."
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "Packages upgraded!"

# Step 3: Install essential tools `gnupg` and `curl`
# - `gnupg` is required for key management.
# - `curl` is used to fetch files from URLs.
sudo apt-get install -y gnupg curl

# Step 4: Import MongoDB public GPG key
# - Downloads MongoDB's GPG key for verifying package integrity.
# - Converts it into a format usable by `apt` and installs it.
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
  gpg --dearmor | \
  sudo install -D -m 644 /dev/stdin /usr/share/keyrings/mongodb-server-7.0.gpg

# Step 5: Add the MongoDB repository to the package manager
# - Adds a new source for MongoDB packages.
# - Specifies the repository key and Ubuntu version (jammy).
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Step 6: Reload the package database
# - Ensures the package manager is aware of the newly added MongoDB repository.
sudo apt-get update -y

# Step 7: Install MongoDB Community Server version 7.0.6
# - Installs specific versions of MongoDB components.
# - Includes `mongodb-org`, `database`, `server`, `mongosh`, `mongos`, and `tools`.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

# Step 8: Prevent accidental upgrades of MongoDB
# - Locks the installed versions of MongoDB packages to avoid unintended updates.
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Step 9: Start the MongoDB service
# - Starts the `mongod` service (MongoDB daemon).
sudo systemctl start mongod

# Step 10: Enable MongoDB to start at boot
# - Ensures MongoDB starts automatically after system reboots.
sudo systemctl enable mongod

# Step 11: Modify MongoDB configuration
# - Updates `mongod.conf` to allow connections from any IP address.
# - Changes `bindIp` value from `127.0.0.1` (localhost) to `0.0.0.0` (all interfaces).
sudo sed -i 's/^  bindIp: 127\.0\.0\.1/  bindIp: 0.0.0.0/' /etc/mongod.conf

# Step 12: Restart MongoDB to apply configuration changes
# - Restarts the `mongod` service to use the updated configuration.
sudo systemctl restart mongod

echo "MongoDB installation and setup completed!"
