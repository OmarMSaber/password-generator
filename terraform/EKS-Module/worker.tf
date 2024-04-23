resource "aws_iam_role" "Todo-eks-nodegroup" {
  name = "Todo-eks-nodegroup"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "Todo-eks-nodegroup-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.Todo-eks-nodegroup.name
}

resource "aws_iam_role_policy_attachment" "Todo-eks-nodegroup-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.Todo-eks-nodegroup.name
}

resource "aws_iam_role_policy_attachment" "Todo-eks-nodegroup-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.Todo-eks-nodegroup.name
}

resource "aws_eks_node_group" "Todo-eks-nodegroup" {
  cluster_name    = var.cluster-name
  node_group_name = "Todo-eks-nodegroup"
  node_role_arn   = aws_iam_role.Todo-eks-nodegroup.arn
  subnet_ids      = var.private-subnets
  
  tags = { 
    "kubernetes.io/cluster/${var.cluster-name}" = "owned" 
    "k8s.io/cluster-autoscaler/${var.cluster-name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"	="TRUE"
  }

  scaling_config {
    min_size = 1
    desired_size = 1
    max_size = 3
  }

  # launch_template {
  #   id      = aws_launch_template.Todo-eks-ng-ltemp.id
  #   version = "$Latest"
  # }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.Todo-eks-nodegroup-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.Todo-eks-nodegroup-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.Todo-eks-nodegroup-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.Todo-eks
  ]
}

