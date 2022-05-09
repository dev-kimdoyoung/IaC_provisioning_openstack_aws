variable "profile" {
	description	= "Choose one DEV | STG | PRD"
	type		= string
}

variable "controller_ssh_password" {
	description	= "set account password to connect ssh to controller node"
  	type 		= string
}

variable "avail_zones" {
	description	= "infra available zones list"
	type		= list
}

variable "vpc_name" {
	description	= "set vpc name"
	type		= string
}

variable "vpc_cidr" {
	description	= "vpc cidr block"
	type		= string
}

variable "public_subnet_cidr" {
	description	= "public subnet cidr in vpc"
	type		= string
}

# variable "pri_sub_cidr" {
# 	description	= "private subnet cidr in vpc"
# 	type 		= list
# }

variable "controller_node_count" {
	description	= "k8s master node count"
	type		= number
}

variable "controller_node_ip" {
	description	= "k8s master node' ec2 private ip"
	type		= list
}

variable "compute_node_count" {
        description     = "k8s worker node count"
        type            = number
}

variable "compute_node_ip" {
        description     = "k8s worker node' ec2 private ip list"
        type            = list
}

# variable "bastion_node_count" {
# 	description	= "bastion node count"
# 	type		= number
# }

# variable "bastion_node_ip" {
# 	description	= "bastion node private ip list"
# 	type		= list
# }
