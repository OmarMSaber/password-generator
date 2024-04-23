resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Todo-eks-igw.id
    }
    tags = { Name = "public-rt" }
}

resource "aws_route_table" "private-rt-one" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw-one.id
    }
    tags = { Name = "private-rt-one" }
}

resource "aws_route_table" "private-rt-two" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw-two.id
    }
    tags = { Name = "private-rt-two" }
}

resource "aws_route_table_association" "rt-associ-public-one" {
  subnet_id      = aws_subnet.public-sub-one.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt-associ-public-two" {
  subnet_id      = aws_subnet.public-sub-two.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt-associ-private-one" {
  subnet_id      = aws_subnet.private-sub-one.id
  route_table_id = aws_route_table.private-rt-one.id
}

resource "aws_route_table_association" "rt-associ-private-two" {
  subnet_id      = aws_subnet.private-sub-two.id
  route_table_id = aws_route_table.private-rt-two.id
}



