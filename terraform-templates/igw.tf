
resource "aws_internet_gateway" "streaming_infra_igw" {
  vpc_id = aws_vpc.streaming_infra.id
  tags = {
    Name = "Streaming-infra-VPC-internet-gateway"
  }
}

