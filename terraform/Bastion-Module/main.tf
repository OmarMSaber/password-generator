resource "aws_security_group" "bastion-sg-ssh" {
  name = "bastion-sg-ssh"
  vpc_id = var.vpc-id 

  tags = {
      Name = "bastion-sg-ssh"
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_instance" "bastion-server" {

  ami = var.ami-bastion
  instance_type = "t2.micro"
  subnet_id = var.public-subnets[0] 
  
  tags = { Name = "bastion-server" }

  vpc_security_group_ids = ["${aws_security_group.bastion-sg-ssh.id}"]

  monitoring = true

  root_block_device {
    delete_on_termination = true
    volume_size = 12
  }

 key_name = var.key-name

 associate_public_ip_address = true
}

resource "aws_eip" "bastion-eip" {
  instance = aws_instance.bastion-server.id
  vpc = true
  tags = { Name = "bastion-eip" }
}


