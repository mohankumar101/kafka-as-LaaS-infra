resource "aws_eip" "streaming_infra_nat_eip" {
    tags = {
      Name = "streaming-infra-ElasticIP"
    }
}

