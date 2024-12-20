# Azure - Virtual Machine

## Step 1: Create a VM

To create a VM for the Node.js app, go to: [vm-for-nodejs-and-mongodb.md](vm-for-nodejs-and-mongodb.md)

## Step 2. Connect to the VM & create a script file
- `ssh -i ~/.ssh/hakuma-keyz devop-user@20.90.116.128`
- nano `nodejs-provision.sh`
- Copy the code from [nodejs-provision.sh](nodejs-provision.sh) and paste it in the file.
- `Ctrl+S`, followed by `Ctrl+X`
- `sudo chmod +x db-prov.sh`
- `./provision.sh`
- `bash nodejs-app-provision.sh` => another way to execute

### Other pm2 Commands
- List Running Applications: `pm2 list`
- Save the pm2 process list: `pm2 save`
- View Logs: `pm2 logs`
- Stop an Application: `pm2 stop <app_name_or_id>`
- Restart an Application: `pm2 restart <app_name_or_id>`
- Monitor your app in real-time: `pm2 monit`
