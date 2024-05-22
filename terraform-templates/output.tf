output "vpc_id" {
    description = "Zookeeper VPC ID"
    value = aws_vpc.streaming_infra.id
}

output "bastion_ec2_public_dns" {
    description = "All the EC2 instance data"
    value = aws_instance.bastion.public_dns
}

output "zk_ec2_private_ip" {
    description = "All the EC2 instance data"
    value = aws_instance.zk_ec2[*].private_ip
}
output "kafka_ec2_private_ip" {
    description = "All the EC2 instance data"
    value = aws_instance.kafka_ec2[*].private_ip
}