resource "aws_security_group" "master-node-sg" {
  name = "master-node-sg"
  vpc_id = var.vpc-id
  tags = { 
    Name = "master-node-sg" 
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_security_group_rule" "master-node-sg-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.master-node-sg.id
  source_security_group_id = aws_security_group.worker-node-sg.id 
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "master-node-sg-ingress-workstation-https" {
  cidr_blocks       =  [var.vpc-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.master-node-sg.id
  to_port           = 65535
  type              = "ingress"
}

resource "aws_security_group_rule" "master-node-sg-from-specific-ports" {
  cidr_blocks       =  [var.vpc-cidr]
  description       = "Allow access from specific ports"
  from_port         = 8001
  protocol          = "tcp"
  security_group_id = aws_security_group.master-node-sg.id
  to_port           = 8010
  type              = "ingress"
}

resource "aws_security_group" "worker-node-sg" {
  name        = "worker-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.vpc-id 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      Name = "worker-node-sg"
      "kubernetes.io/cluster/${var.cluster-name}" = "owned"
    }
}

resource "aws_security_group_rule" "worker-node-sg-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "All"
  security_group_id        = aws_security_group.worker-node-sg.id
  source_security_group_id = aws_security_group.worker-node-sg.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-node-sg-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker-node-sg.id
  source_security_group_id = aws_security_group.master-node-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "bastion_ssh" {
  description = "ssh from bastion to node"
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  security_group_id = aws_security_group.worker-node-sg.id
  source_security_group_id = var.bastion-sg
  }