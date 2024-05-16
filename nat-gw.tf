resource "aws_nat_gateway" "streaming_infra_nat" {
  allocation_id = aws_eip.streaming_infra_nat_eip.id
  subnet_id     = aws_subnet.streaming_infra_public_subnets.id
  tags = {
      Name = "Streaming-infra-NAT"
    }
  depends_on = [aws_eip.streaming_infra_nat_eip]
}
