resource "aws_vpc" "Todo-eks-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {Name = "Todo-eks-vpc"}
}

resource "aws_vpc_dhcp_options" "dhcpos" {
  domain_name         = "${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_key_pair" "Todo-eks-key" {
  key_name = "Todo-eks-key"
  public_key = var.key-pair
}

resource "aws_subnet" "public-sub-one" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    cidr_block = var.public-subnet1-cidr
    tags = { 
        Name = "public-subnet-one"
        "kubernetes.io/cluster/${var.cluster-name}" = "shared" 
        "kubernetes.io/role/elb" = "1"   
    }
}

resource "aws_subnet" "public-sub-two" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    cidr_block = var.public-subnet2-cidr
    tags = { 
        Name = "public-subnet-two"
        "kubernetes.io/cluster/${var.cluster-name}" = "shared" 
        "kubernetes.io/role/elb" = "1"  
    }
}

resource "aws_subnet" "private-sub-one" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
    cidr_block = var.private-subnet1-cidr
    tags = { 
        Name = "private-subnet-one" 
        "kubernetes.io/cluster/${var.cluster-name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1" 
    }
}

resource "aws_subnet" "private-sub-two" {
    vpc_id = aws_vpc.Todo-eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = false
    cidr_block = var.private-subnet2-cidr
    tags = { 
        Name = "private-subnet-two" 
        "kubernetes.io/cluster/${var.cluster-name}" = "shared" 
        "kubernetes.io/role/internal-elb" = "1"   
    }
}

