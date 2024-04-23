resource "aws_iam_role" "Todo-eks-iamrole" {
  name = "Todo-eks-iamrole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "Todo-eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.Todo-eks-iamrole.name
}

resource "aws_iam_role_policy_attachment" "Todo-eks-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.Todo-eks-iamrole.name
}

resource "aws_eks_cluster" "Todo-eks" {
  name     = var.cluster-name
  role_arn = aws_iam_role.Todo-eks-iamrole.arn
  vpc_config {
    # security_group_ids = [aws_security_group.master-node-sg.id]
    subnet_ids = var.private-subnets
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.Todo-eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.Todo-eks-AmazonEKSServicePolicy,
  ]
}







