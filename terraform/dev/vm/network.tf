################################################
#		VPC Network Settings
################################################

resource "aws_vpc" "openstack_vpc" {
	cidr_block	= var.vpc_cidr

	tags = {
		Name = "${var.vpc_name}-${var.profile}-infra"
	}
}

################################################
#		Public Network Settings
################################################
resource "aws_subnet" "openstack_public_subnet" {
	vpc_id			= aws_vpc.openstack_vpc.id
	cidr_block		= var.public_subnet_cidr
	availability_zone	= var.avail_zones[1]

	tags = {
        	Name = "${var.vpc_name}-${var.profile}-public-net"
    	}
}

resource "aws_internet_gateway" "public_igw" {

	vpc_id = aws_vpc.openstack_vpc.id
	
	tags = {
		Name = "${var.vpc_name}-${var.profile}-Internet-Gateway"
	}
}

resource "aws_route_table" "public_rt" {
	vpc_id	= aws_vpc.openstack_vpc.id

	tags = {
		Name = "${var.vpc_name}-${var.profile}-public-Route-Table"
	}
}

resource "aws_route" "public_route" {
	route_table_id		= aws_route_table.public_rt.id
	gateway_id			= aws_internet_gateway.public_igw.id
	destination_cidr_block	= "0.0.0.0/0"
}

resource "aws_route_table_association" "public_RTA" {
	subnet_id	= aws_subnet.openstack_public_subnet.id
	route_table_id	= aws_route_table.public_rt.id
}

################################################
#		Private Network Settings
################################################
# resource "aws_subnet" "openstack_private_subnet" {
#         count                   = length(var.pri_sub_cidr)
#         vpc_id                  = aws_vpc.k8s_vpc.id
#         cidr_block              = var.pri_sub_cidr[count.index]
#         availability_zone       = var.avail_zones[count.index]

#         tags = {
#                 Name = "${var.vpc_name}-${var.profile}-private-${substr("${var.avail_zones[count.index]}", -1, 1)}-${count.index}"
#         }
# }

# resource "aws_eip" "nat_static_ip" {
# 	vpc = true

# 	lifecycle {
# 		create_before_destroy = true
# 	}
# }

# resource "aws_nat_gateway" "nat_gw" {
# 	allocation_id = aws_eip.nat_static_ip.id
# 	subnet_id     = aws_subnet.public_subnet.id

# 	tags = {
# 		Name = "NAT-GW"
# 	}
# }

# resource "aws_route_table" "private" {
#         vpc_id  = aws_vpc.openstack_vpc.id

#         tags = {
#                 Name = "private-RT"
#         }
# }

# resource "aws_route" "private_route" {
#         route_table_id          = aws_route_table.private.id
#         nat_gateway_id          = aws_nat_gateway.nat_gw.id
#         destination_cidr_block  = "0.0.0.0/0"
# }

# resource "aws_route_table_association" "private_RTA" {
#         count           = length(var.pri_subnet_cidr)
#         subnet_id       = aws_subnet.openstack_private_subnet[count.index].id
#         route_table_id  = aws_route_table.private.id
# }
