resource "aws_key_pair" "openstack_key" {
	key_name	= "local-to-public-key-pair"
	public_key	= file("~/.ssh/ec2_admin.pub")
	tags =	{
		Name	= "admin-key-pair"
	}
}
