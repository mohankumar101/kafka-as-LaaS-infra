/* Apptier - private subnet */

resource "aws_subnet" "streaming_infra_private_subnets" {
    vpc_id                  = aws_vpc.streaming_infra.id
    cidr_block              = var.serverconfig.streaming_infra.private_subnets
    availability_zone       = var.serverconfig.streaming_infra.infra_avail_zone
    tags = {
        Name        = "Streaming-infra-private-subnet"
    }
}

resource "aws_route_table" "private_routing_table" {
  vpc_id = aws_vpc.streaming_infra.id
  tags = {
    Name = "Streaming-infra-private-RT"
  }
}

### route table association for the private subnet
resource "aws_route_table_association" "private_rta" {
    subnet_id = aws_subnet.streaming_infra_private_subnets.id
    route_table_id = aws_route_table.private_routing_table.id
}

### Route for reaching internet from private subnets
resource "aws_route" "streaming_infra_private_subnet_internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private_routing_table.id
  gateway_id = aws_nat_gateway.streaming_infra_nat.id
}
