
# Create bastion host, which is the landing machine to access all EC2 machines

resource "aws_instance" "bastion" {
        instance_type   = "t3.micro"
        ami             = data.aws_ami.zk_ec2_amidata.id
        key_name        = var.serverconfig.streaming_infra.ec2_key_name
        subnet_id       = aws_subnet.streaming_infra_public_subnets.id
        associate_public_ip_address = true
        security_groups = [ aws_security_group.bastion_allow_ssh_sg.id ]
        tags = {
            Name = "Bastion Host for SSH access"
        }
}
