# App and MongoDB Virtual Machines

## Steps to creating a virtual machine in Azure

## Creating a Virtual Machine

- Search for virtual machine and click it
- From the Create dropdown, select `Azure virtual maching`
- Select Subscription
- Select Resource group
- Virtual machine name: `cloudfun1-rasheed-uks-test-vm`
- Region: (Europe) UK South
- Availability options: select `Availability zone`
- Availability zone: select Zone 1
- Security type: Accept default or Standard
- Image: Select Ubuntu Server 22.04 LTS - x64 Gen2
- Alternatively, select `See all images` and search for Ubuntu
- Select Ubuntu Pro 18.04 LTS Gen2
- VM architecture: accept default `x64`
- Size: click `See all sizes`
- Then select `B1s` family and the click the `Select` button
- Authentication type: `SSH public key`
- Username: You get a default `azureuser`.
- Change the username to something else: **rasheed-admin-user**
- SSH public key source: select `Use existing key stored in Azure`
- Stored Keys: `cloudfun1-rasheed-az-key`
- Public inbound ports: Select `Allow selected ports`
- Select inbound ports: Select `SSH(22)`
- Click `Next: Disks`
  - OS disk type: Select `Standard SSD(locally-redundant-storage)`
  - Delete with VM: `Check the box`
  - For the rest, accept the default
    Click `Next: Networking`
- If you have an existing vnet, you can select it from the dropdown
- Virtual network: You can select an existing one or create a new one
- Click Create new
  - Name: `cloudfun1-rasheed-uks-main-vnet`
  - VNet has Subnet inside it.
  - Every VNet has an Address range
  - Address range: Change it from `10.1.0.0/16` to `10.0.0.0/16`
  - Subnets: We will create two subnets. One private and one public
  - Subnet name: public-subnet => Address range: 10.0.2.0/24
  - Subnet name: private-subnet => Address range: 10.0.3.0/24
  - Click OK
- Subnet: select `private-subnet`
- NIC network security group: Basic
- Public inbound ports: Allow selected ports
- Select inbound ports: HTTPS, SSH
- Delete public IP and NIC when VM is deleted: Tick this box
- Click `Next: Management`
  - Accept default
- Click `Next: Monitoring`
  - Accept default
- Click `Next: Advanced`
  - Accept default
- Click `Next: Tags`
  - owner: rasheed
- Click `Review + create`
  - Then click Create

## 1. Creating a Virtual Machine for MongoDB

- To create a VM for the database, follow the steps above.
- Note the following changes for the MongoDB virtual machine
- Virtual machine name: `cloudfun1-rasheed-uks-sparta-app-db-vm`
- Availability options: select `Availability zone`
- Availability zone: select `Zone 2`
- Image: `Select Ubuntu Server 22.04 LTS - x64 Gen2`
- Username: `rasheed-admin-user`
- Public inbound ports: Select `Allow selected ports`
- Select inbound ports: Select `SSH(22)`
- Subnet: select `private-subnet`
- Select inbound ports: HTTPS, SSH
- Delete public IP and NIC when VM is deleted: `Tick this box`
- Then click Create

## 2. Creating a Virtual Machine for the Node.js App

- To create a VM for the database, follow the steps above.
- Note the following changes for the MongoDB virtual machine
- Region: (Europe) UK South
- Availability zone: select Zone 1
- Security type: Standard
- Image: Select Ubuntu Server 22.04 LTS - x64 Gen2
- Username: `devop-user`
- SSH public key source: `Use existing key stored in Azure`
- Stored Keys: `cloudfun1-rasheed-az-key`
- Public inbound ports: Select `Allow selected ports`
- Select inbound ports: Select `SSH(22), HTTP(80)`
- Click `Next: Disks`
  - OS disk type: `Standard SSD(locally-redundant-storage)`
  - Delete with VM: `Check the box`
- Click `Next: Networking`
- Virtual network: select `cloudfun1-rasheed-az-key`
- Subnet: `public-subnet (10.0.2.0/24)`
- NIC network security group: `Advanced`
- Configure network security group: Click `Create new`
  - Name: `cloudfun1-rasheed-uks-sparta-app-nsg`
  - Click `Add an inbound rule`
  - Destination port ranges: 80
  - Destination port ranges: 3000
  - Press OK
- Then continue
- Delete public IP and NIC when VM is deleted: `Tick this box`
- Click `Review + create`

## SSH into the VM
- Open your VM and click Connect button
- Under `Native SSH`: Click Select
- Copy and execute SSH command:
- This time we add `~/.ssh/` to the code, and we can ssh from any location.
- `ssh -i ~/.ssh/cloudfun1-rasheed-az-key rasheed-admin-user@20.108.64.8`
- Are you sure you want to continue connecting: `yes`