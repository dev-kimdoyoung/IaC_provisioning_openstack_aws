resource "aws_instance" "openstack_controller_node" {
	ami          		= var.os_image
	instance_type		= "t3.small"	# Memory 2 GB & vCPUs 2
    key_name            = aws_key_pair.openstack_key.key_name

	subnet_id		    = aws_subnet.openstack_public_subnet.id
	count				= var.controller_node_count
	private_ip			= var.controller_node_ip[count.index]

	associate_public_ip_address	= true

	# include VPC Security Group
	vpc_security_group_ids = [
		aws_security_group.openstack_security_group.id
	]

	tags = {
		Name = "${var.vpc_name}-${var.profile}-${aws_subnet.openstack_public_subnet.cidr_block}-${count.index}"
	}

    # Connection Information
    connection {
            host = self.public_ip
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/ec2_admin")}"
            timeout = "2m"
    }


    provisioner "remote-exec" {
            inline = [
                # install Packages (ssh, ansible, python3, pip3)
                "sudo dnf install -y ssh",
                "sudo useradd -s /bin/bash -m bastion",
                "echo 'bastion:${var.controller_ssh_password}' | sudo chpasswd",
                "sudo usermod -aG wheel bastion",
                "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config",
                "sudo systemctl restart sshd",
                # "sudo echo '%wheel ALL=(ALL)    NOPASSWD: ALL' >> /etc/sudoers",
            ]
    }
}


# resource "aws_instance" "openstack_compute_node" {
# 	ami          		= var.os_image
# 	instance_type		= "t3.small"	# Memory 2 GB & vCPUs 2
#     key_name            = aws_key_pair.openstack_key.key_name

#     subnet_id		    = aws_subnet.openstack_public_subnet.id
# 	count				= var.compute_node_count
# 	private_ip			= var.compute_node_ip[count.index]

# 	associate_public_ip_address	= true

# 	# include VPC Security Group
# 	vpc_security_group_ids = [
# 		aws_security_group.openstack_security_group.id
# 	]

# 	tags = {
# 		Name = "${var.vpc_name}-${var.profile}-${aws_subnet.openstack_public_subnet.cidr_block}-${count.index}"
# 	}

#     # Connection Information
#     connection {
#             host = self.public_ip
#             type = "ssh"
#             user = "ec2-user"
#             private_key = "${file("~/.ssh/ec2_admin")}"
#             timeout = "2m"
#     }


#     provisioner "remote-exec" {
#             inline = [
#                 "sudo dnf install -y ssh",
#                 "sudo useradd -s /bin/bash -m bastion",
#                 "echo 'bastion:${var.controller_ssh_password}' | sudo chpasswd",
#                 "sudo usermod -aG wheel bastion",
#                 "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config",
#                 "sudo systemctl restart ssh",
#                 "sudo echo '%wheel ALL=(ALL)    NOPASSWD: ALL' >> /etc/sudoers"
#             ]
#     }
# }

# resource "aws_instance" "bastion_node" {
#         ami                             = "ami-0e67aff698cb24c1d" # Ubuntu 18:04 / KR
#         instance_type                   = "t3.small"    # Memory 2 GB & vCPUs 2
#         key_name                        = aws_key_pair.ec2_admin.key_name
#         subnet_id                       = aws_subnet.k8s_public_subnet.id

#         count                           = var.bastion_node_count
#         private_ip                      = var.bastion_node_ip[count.index]

#         associate_public_ip_address     = true

#         # include VPC Security Group
#         vpc_security_group_ids = [
#                 aws_security_group.allow_SSH.id
#         ]

#         tags = {
#                 Name = "bastion-node-${count.index}"
#         }

#         connection {
# 		host = self.public_ip
# 		type = "ssh"
#                 user = "ubuntu"
#                 private_key = "${file("~/.ssh/ec2_admin")}"
#                 timeout = "2m"
#         }


#         provisioner "remote-exec" {
#                 inline = [
#                         "sudo apt-get upgrade -y",
#                         "sudo apt-get update -y",
# 			"sudo apt-get install software-properties-common -y",
# 			"sudo apt-add-repository ppa:ansible/ansible -y",
# 			"sudo apt-get update",
#                         "sudo apt-get install ansible -y",
#                 ]
#         }
# }
