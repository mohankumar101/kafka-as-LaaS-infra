# Bastion host security group, accepts only port 22 traffic 

resource "aws_security_group" "bastion_allow_ssh_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.streaming_infra.id

  tags = {
    Name = "Streaming-infra-Bastion-host-allowssh-security-group"
  }
}

# Refine the below ingress rule after testing - to your onprem network IP range to reduce attack vector

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.bastion_allow_ssh_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.bastion_allow_ssh_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
