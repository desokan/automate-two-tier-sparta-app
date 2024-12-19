# App and MongoDB Virtual Machines

## 1. Creating a Virtual Machine for MongoDB

- To create a VM for the database, follow the steps in the `azure-virtual-machine.md` file.
- The differences are highlighted below.
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
- 
- Open your VM and click Connect button
- Under `Native SSH`: Click Select
- Copy and execute SSH command:
- This time we add `~/.ssh/` to the code, and we can ssh from any location.
- `ssh -i ~/.ssh/cloudfun1-rasheed-az-key rasheed-admin-user@20.108.64.8`
- `ssh -i ~/.ssh/hakuma-keyz devop-user@20.90.177.255`
- Are you sure you want to continue connecting: yes