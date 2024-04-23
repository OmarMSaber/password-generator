output "private-one-id" {
  value = aws_subnet.private-sub-one.id 
}

output "private-two-id" {
  value = aws_subnet.private-sub-two.id 
}

output "vpc-id" {
  value = aws_vpc.Todo-eks-vpc.id
}

output "vpc-cidr" {
  value = var.vpc-cidr
}

output "key-pair" {
  value = aws_key_pair.Todo-eks-key.key_name
}

output "available-zone" {
  value = data.aws_availability_zones.available.names[1]
}

output "public-one-id" {
  value = aws_subnet.public-sub-one.id 
}

output "public-two-id" {
  value = aws_subnet.public-sub-two.id 
}
