### Data block does lookup for AMI data, and find the matching AMI, this helps in avoiding hardcoded AMIs, outdated AMIs etc

data "aws_ami" "zk_ec2_amidata" {
  most_recent   = true
  owners        = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_ami" "kafka_ec2_amidata" {
  most_recent   = true
  owners        = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

### Iterating over the availability zones to create EC2 for each AZ

resource "aws_instance" "zk_ec2" {
    count = 3
        ami                         = data.aws_ami.zk_ec2_amidata.id
        instance_type               = var.serverconfig.streaming_infra.zk_ec2_inst_type
        key_name                    = var.serverconfig.streaming_infra.ec2_key_name
        vpc_security_group_ids      = [ aws_security_group.allow_zk_traffic.id ]
        subnet_id                   = aws_subnet.streaming_infra_private_subnets.id
        tags = {
            name = "${var.serverconfig.streaming_infra.infra_env}_zookeeper_member_${count.index}"
            terraform = "true"
            env = var.serverconfig.streaming_infra.infra_env
            infra = "streaming"
            service = "zookeeper"
        }
}

resource "aws_instance" "kafka_ec2" {
  count = 3
        ami                         = data.aws_ami.kafka_ec2_amidata.id
        instance_type               = var.serverconfig.streaming_infra.kafka_ec2_inst_type
        key_name                    = var.serverconfig.streaming_infra.ec2_key_name
        vpc_security_group_ids      = [ aws_security_group.allow_kafka_traffic.id ]
        subnet_id                   = aws_subnet.streaming_infra_private_subnets.id
        tags = {
            name = "${var.serverconfig.streaming_infra.infra_env}_kafka_member_${count.index}"
            terraform = "true"
            env = var.serverconfig.streaming_infra.infra_env
            infra = "streaming"
            service = "kafka"
        }
}