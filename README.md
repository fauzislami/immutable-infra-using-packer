# Description

In this repo consist of configurations in order to create custom AMI ( *Amazon Machine Image* ) with pre-configured services and ready to deploy. Packer, Ansible and Terraform are combined along this lab. Packer is used to build custom images which needs a provisioner to manage configuration on that image, so here Ansible comes into play. After the image has been built and stored on AWS as AMI, Terraform will take an action to deploy a VM using that image. This lab will be only using free-tier AWS services which will not cost us during the practice. Let's see how the labs summary :

- Region = ap-southeast-3 (Jakarta)
- Availability Zone = ap-southeast-3a
- Accessible Port = 22 (SSH) & 80 (HTTP)
- Base AMI = Amazon Linux 2 AMI (HVM)

Obviously those parameters above are customizable.

## Overall steps

**Step 1**: Setup a network using Terraform Setup VPC (Network, Subnetwork, SSH Key, Security Groups).

**Step 2**: Create AMI using Packer and Ansible as its provisioner (using network created in Step 1).

**Step 3**: Deploy EC2 Instance using the previous built image by Packer.

Provide access key and token in Terraform and Packer code.
We can provide access key and token either in Terraform and Packer code or apply them as environment variables like below :

> AWS_ACCESS_KEY_ID=xxxxxxxxx & AWS_SECRET_ACCESS_KEY=xxxxxxxxx

### Setup VPC

Go to terraform-conf/network-tf folder, then run command: 

<code>terraform init</code>

<code>terraform plan </code>

<code>terraform apply</code> after that, *type* **yes** to continue 

### Build AMI by running Packer

Don't forget to provide subnet_id to aws-nginx.pkr.hcl file which is created in VPC creation on the previous step. Afterwards, run the command below :

1. By going to the directory where packer configuration file exists

<code>packer build .</code> 


OR


2. We can just simply call the file

<code>packer build aws-nginx.pkr.hcl</code>

In this phase, Ansible will be invoked to run playbook inside Packer builders.

### Deploy EC2 Instance using Terraform

Go to terraform-conf/instance-tf, by running the command below: 

<code>terraform init</code>

<code>terraform plan</code>

<code>terraform apply</code> after that, *type* **yes** to continue 

### Time to clean up :smile:

Don't forget to destroy the running instance, by simply hitting this command :

<code>terraform destroy -auto-approve</code>

And the last is don't forget to **deregister** our customized AMI by accessing it via AWS Console and also **delete** the snapshot created during AMI creation, otherwise we'll be charged.