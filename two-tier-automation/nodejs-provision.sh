#!/bin/bash

# Step 1: Update the package database
# - Ensures the latest package information is available.
sudo apt-get update -y

# Step 2: Upgrade installed packages
# - Updates all installed packages to their latest versions.
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Step 3: Install Nginx web server
# - Installs the Nginx web server.
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y

# Step 4: Configure Nginx as a reverse proxy
# - Updates the default Nginx configuration to proxy requests to a local Node.js app running on port 3000.
echo "Creating reverse proxy..."
sudo sed -i 's|try_files.*;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
echo "Reverse proxy configuration completed!"

# Step 5: Download and install Node.js
# - Downloads the Node.js setup script for version 20.x.
# - Runs the setup script to configure the package manager.
# - Installs Node.js and npm (Node.js package manager).
echo "Downloading and installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x -o setup_nodejs.sh
sudo DEBIAN_FRONTEND=noninteractive bash setup_nodejs.sh
sudo DEBIAN_FRONTEND=noninteractive apt-get install nodejs -y
echo "Node.js installation completed!"

# Step 6: Display Node.js and npm versions
# - Confirms the installation by displaying the installed versions of Node.js and npm.
echo "Node.js and npm versions:"
node -v
npm -v
echo "Version check completed!"

# Step 7: Restart Nginx to apply the reverse proxy configuration
# - Restarts the Nginx service to use the updated configuration.
echo "Restarting Nginx..."
sudo systemctl restart nginx
echo "Nginx restarted!"

# Step 8: Enable Nginx to start at boot
# - Ensures Nginx starts automatically after system reboots.
echo "Enabling Nginx..."
sudo systemctl enable nginx
echo "Nginx enabled!"

# Step 9: Clone the application repository
# - Clones the app repository from GitHub to the local system.
echo "Cloning the application repository..."
git clone https://github.com/desokan/my-sparta-app.git
echo "Repository cloned!"

# Step 10: Install PM2 process manager globally
# - Installs PM2 to manage the Node.js app as a service.
echo "Installing PM2..."
sudo npm install -g pm2
echo "PM2 installation completed!"

# Step 11: Change to the app directory
# - Navigates to the application directory after cloning.
cd /my-sparta-app/app

# Step 12: Set up the database environment variable
# - Configures the database connection string using a MongoDB IP address.
# - Temporarily sets the environment variable for the current session.
echo "Creating environment variable for database connection..."
export DB_HOST=mongodb://10.0.3.4:27017/posts
echo "Environment variable created!"

# Step 13: Persist the environment variable across reboots
# - Adds the environment variable to `.bashrc` so it's available in future sessions.
echo 'export DB_HOST=mongodb://10.0.3.4:27017/posts' >> ~/.bashrc

# Step 14: Confirm the environment variable is set
# - Displays the value of the `DB_HOST` variable to verify it was created.
echo "Confirming environment variable..."
printenv DB_HOST
echo "Environment variable confirmed!"

# Step 15: Install app dependencies
# - Installs the required dependencies listed in `package.json`.
echo "Installing application dependencies..."
npm install
echo "Dependencies installed!"

# Step 16: Stop the app if it is already running
# - Ensures idempotency by stopping any existing instance of the app.
echo "Stopping any running instances of the app..."
pm2 kill # Alternative: pm2 stop all
echo "Existing app instances stopped!"

# Step 17: Start the Node.js app with PM2
# - Uses PM2 to start the application and manage it as a background process.
echo "Starting the Node.js application..."
pm2 start app.js
echo "Application started!"

# Step 18: Save the PM2 process list
# - Saves the PM2 process list to ensure the app restarts on reboot.
sudo pm2 save

# Step 19: Enable PM2 startup on system boot
# - Configures PM2 to start automatically after a reboot.
sudo pm2 startup
