module "openstack_infra" {
	source					= "../vm/"
	profile					= "dev"
	avail_zones				= ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
	vpc_name				= "openstack-system"
	vpc_cidr				= "172.31.0.0/16"
	public_subnet_cidr		= "172.31.100.0/24"
	# pri_subnet_cidr			= ["172.31.101.0/24", "172.31.102.0/24", "172.31.103.0/24"]
	controller_node_count	= 1
	controller_node_ip		= ["172.31.100.100"]
	compute_node_count		= 3
	compute_node_ip			= ["172.31.100.101", "172.31.100.102", "172.31.100.103"]
	# bastion_node_count		= 1
	# bastion_node_ip			= ["172.31.0.10"]
	controller_ssh_password	= "{please input your password}"
}