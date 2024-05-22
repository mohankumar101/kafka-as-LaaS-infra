### enable_dns* arguments are to enable public IP for VPC instances, otherwise they will end up having a private IP only - inaccessible from internet 

resource "aws_vpc" "streaming_infra" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "Streaming Infra VPC-${var.serverconfig.streaming_infra.infra_env}"
    terraform = "true"
    env = var.serverconfig.streaming_infra.infra_env
    infra = "streaming"
  }
  enable_dns_hostnames = true
  enable_dns_support   = true
}

