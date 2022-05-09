output "vpc_total_network" {
	value = "${aws_vpc.openstack_vpc.cidr_block}"
}

output "public_total_network" {
	value = "${aws_subnet.openstack_public_subnet.cidr_block}"
}
