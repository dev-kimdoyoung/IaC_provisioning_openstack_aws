# --------------------------------------------------------
# 			Dev environment Security Group
# --------------------------------------------------------
resource "aws_security_group" "openstack_security_group" {
	name        = "openstack-security-group"
	description = "controll all traffics between internet and openstack system"
  	vpc_id      = aws_vpc.openstack_vpc.id

# --------------------------------------------------------
#		Inbound = allow Below Traffic
#		- SSH (TCP)
# --------------------------------------------------------
        ingress {
                description = "SSH from VPC"
                from_port   = 22
                to_port     = 22
                protocol    = "TCP"
                cidr_blocks = ["0.0.0.0/0"]
        }

# --------------------------------------------------------
#               Inbound = allow Below Traffic
#               - HTTP (TCP)
# --------------------------------------------------------
    ingress {
            description = "HTTP from VPC"
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
    }

# --------------------------------------------------------
#               Inbound = allow Below Traffic
#               - HTTPS (TCP)
# --------------------------------------------------------
    ingress {
            description = "HTTPS from VPC"
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
	}


# --------------------------------------------------------
#               Inbound = allow Below Traffic
#               - for Worker Node
# --------------------------------------------------------
    ingress {
            description = "nodePort Servicest"
            from_port   = 30000
            to_port     = 32768
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
    }

# --------------------------------------------------------
#               Outbound = allow All traffic
# --------------------------------------------------------
    egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"      # allow all protocol
            cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
            Name = "${var.vpc_name}-security-group"
    }
}


