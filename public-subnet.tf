

/* Public subnet */

resource "aws_subnet" "streaming_infra_public_subnets" {
    vpc_id                  = aws_vpc.streaming_infra.id
    cidr_block              = var.serverconfig.streaming_infra.public_subnets
    availability_zone       = var.serverconfig.streaming_infra.infra_avail_zone
    tags = {
        Name        = "Streaming-infra-public-subnet"
    } 
}

### A route table for the VPC
resource "aws_route_table" "streaming_infra_public_routing_table" {
  vpc_id = aws_vpc.streaming_infra.id
  tags = {
    Name = "Streaming-infra-public-RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.streaming_infra_igw.id
  }
}

### route table association for the VPC
resource "aws_route_table_association" "public-RT-association" {
    subnet_id = aws_subnet.streaming_infra_public_subnets.id
    route_table_id = aws_route_table.streaming_infra_public_routing_table.id
}


/*
### Route entry on the routing table, referring to the Internet gateway as route for internet (0.0.0.0/0) 
resource "aws_route" "public_internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.public_routing_table.id
  gateway_id = aws_internet_gateway.lv_internet_gw.id
}
*/



