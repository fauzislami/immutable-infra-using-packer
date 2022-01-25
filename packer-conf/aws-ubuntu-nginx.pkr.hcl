packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws-nginx-v1"
  instance_type = "t3.micro"
  region        = "ap-southeast-3"
  subnet_id     = "subnet-052da304951b09f58"
  tags = {
    Name = "Packer-Ansible"
  }
  # source_ami_filter {
  #   filters = {
  #     name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
  #     root-device-type    = "ebs"
  #     virtualization-type = "hvm"
  #   }
  #   most_recent = true
  #   owners      = ["099720109477"]
  # }
  source_ami   = "ami-0b051c41099539a48"
  ssh_username = "ec2-user"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "../ansible-conf/playbook.yml"
  
  }

#   provisioner "shell" {
#   environment_vars = [
#     "FOO=App v1.0",
#   ]
#   inline = [
#     "echo nginx",
#     "sleep 30",
#     "sudo apt-get update -y",
#     "sudo apt-get install -y nginx",
#     "sudo echo \"FOO is $FOO\" > /usr/share/nginx/html/index.html",
#     "sudo systemctl enable --now nginx"
#   ]
# }

}
