variable "region" {
  default = "ap-southeast-3"
}
variable "vpc_id" {
  description = "VPC id"
  default = ""
}
variable "subnet_public_id" {
  description = "VPC public subnet id"
  default = ""
}
variable "security_group_ids" {
  description = "EC2 ssh security group"
  type = list
  default = ["sg-0cce99458303d62fe", "sg-0aef507aaa60aa1bf"]
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}
variable "key_pair_name" {
  description = "EC2 Key pair name"
  default = ""
}
variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-07e080fee94fdb432"
}
variable "instance_type" {
  description = "EC2 instance type"
  default = "t3.micro"
}