# Creating a bash script

## Step 1: Creating Virtual Machine

To create a VM for MongoDB, go to: [vm-for-nodejs-and-mongodb.md](vm-for-nodejs-and-mongodb.md)

## Step 2: SSH into the MongoDB Virtual Machine

- `ssh -i ~/.ssh/hakuma-keyz devop-user@20.90.164.41`
- `nano mongo-provision.sh`
- Copy the script from [mongo-provision.sh](mongo-provision.sh) and paste it in the `mongo-provision.sh` file
- `Ctrl+S`, followed by `Ctrl+X`
- `sudo chmod +x db-prov.sh`
- `./mongo-provision.sh`
