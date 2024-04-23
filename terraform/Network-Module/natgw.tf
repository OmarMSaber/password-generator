resource "aws_internet_gateway" "Todo-eks-igw" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    tags = { Name = "Todo-eks-igw" }
}

resource "aws_eip" "eip-gw-one" {
  vpc = true
  tags = { Name = "eip-gw-one" }
}


resource "aws_eip" "eip-gw-two" {
  vpc = true
  tags = { Name = "eip-gw-two" }
}

resource "aws_nat_gateway" "nat-gw-one" {
  allocation_id = aws_eip.eip-gw-one.id
  subnet_id     = aws_subnet.public-sub-one.id
  depends_on    = [aws_internet_gateway.Todo-eks-igw]
  tags = { Name = "nat-gw-one" }
}

resource "aws_nat_gateway" "nat-gw-two" {
  allocation_id = aws_eip.eip-gw-two.id
  subnet_id     = aws_subnet.public-sub-two.id
  depends_on    = [aws_internet_gateway.Todo-eks-igw]
  tags = { Name = "nat-gw-two" }
}
