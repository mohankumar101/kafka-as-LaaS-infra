
/*
### Security group for SSH access from/to internet
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.streaming_infra.id

  ingress {
    description = "Allow SSH connections from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all connections to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_SSH SG group"
  }
}
*/

### The following data block provides data for cidr_block_associations
data "aws_vpc" "streaming_infra" {
  id = aws_vpc.streaming_infra.id
}

### VPC's Kafka traffic security group
resource "aws_security_group" "allow_kafka_traffic" {
  name        = "allow_kafka_traffic"
  description = "Allow Kafka inbound/outbound traffic"
  vpc_id      = aws_vpc.streaming_infra.id
  dynamic "ingress" {
        /* What happens below is explained here. 
        Iterator is a variable name to carry the value being read. For each value in the variable ingressrules' list its read and assigned to port. 
        Its then used with port.value to be used in the code 
        */
        iterator = port
        for_each = var.kafka_ingressports
        content {
        from_port = port.value
        to_port =  port.value
        protocol = "TCP"
        cidr_blocks = data.aws_vpc.streaming_infra.cidr_block_associations[*].cidr_block
        }
    }
  dynamic "egress" {
        /* What happens below is explained here. 
        Iterator is a variable name to carry the value being read. For each value in the variable ingressrules' list its read and assigned to port. 
        Its then used with port.value to be used in the code 
        */
        iterator = port
        for_each = var.kafka_egressports
        content {
        from_port = port.value
        to_port =  port.value
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
  
  tags = {
    Name = "Kafka Security Group - Allows kafka ingress and open egress"
  }
}


### VPC's Zookeeper traffic security group
resource "aws_security_group" "allow_zk_traffic" {
  name        = "allow_zk_traffic"
  description = "Allow Zookeeper inbound/outbound traffic"
  vpc_id      = aws_vpc.streaming_infra.id
  dynamic "ingress" {
        /* What happens below is explained here. 
        Iterator is a variable name to carry the value being read. For each value in the variable ingressrules' list its read and assigned to port. 
        Its then used with port.value to be used in the code 
        */
        iterator = port
        for_each = var.zk_ingressports
        content {
        from_port = port.value
        to_port =  port.value
        protocol = "TCP"
        cidr_blocks = data.aws_vpc.streaming_infra.cidr_block_associations[*].cidr_block
        }
    }
  dynamic "egress" {
        /* What happens below is explained here. 
        Iterator is a variable name to carry the value being read. For each value in the variable ingressrules' list its read and assigned to port. 
        Its then used with port.value to be used in the code 
        */
        iterator = port
        for_each = var.zk_egressports
        content {
        from_port = port.value
        to_port =  port.value
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
  
  tags = {
    Name = "Zookeeper Security Group - Allows kafka ingress and open egress"
  }
}
