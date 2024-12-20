# Deployment via User Data

## Creating Virtual Machine for MongoDB
- To create a VM for MongoDB, go to: [001-app-and-mongo-vms.md](../001-app-and-mongo-vms.md)
- In the `Advanced` section, tick `User data` and paste the bash script in the textbox.
- The script can be found at [mongo-provision.sh](../4.%20script%20files/mongo-provision.sh)
- Once done, SSH into the VM, cd to `/`, the `mongod.conf` is in the `/etc` directory.

## Creating Virtual Machine for Node.js
- To create a VM for MongoDB, go to: [001-app-and-mongo-vms.md](../001-app-and-mongo-vms.md)
- In the `Advanced` section, tick `User data` and paste the bash script in the textbox.
- The script can be found at [nodejs-provision.sh](../4.%20script%20files/nodejs-provision.sh)
- Once it's completed, SSH into the VM, cd to `/` and you will see the #

## Testing the deployment works
- You don't need to ssh into either VMs to test the app.
- Simply copy the public ip address of the Node.js VM into the browser.
- `http://20.90.161.205/posts`

## Additional notes
- idempotent => running multiple times without running into any issue 
- bash scripts are not designed to be idempotent 
- research how to make your script idempotent

## Four different ways to deploy an app
1. Manually install after SSH-ing into the VM
2. Use Bash Script to deploy the app
3. Use `User data` to deploy the app
4. Use a `Custom image` to deploy the app

- The way to make things faster is by creating a `Custom Image`.
- Custom data runs as a `super-user`. So, no need to use `sudo`
- The `User data` runs only once. 
- Before you use user-data, you must be sure your script works. 
- The script will run from the root directory (`/`).

Only thing you will need is install the image and then start the app.
