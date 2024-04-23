resource "aws_efs_file_system" "Todo-eks-efs" {
  creation_token = "Todo-eks-efs"

  tags = {
    Name = "Todo-eks-efs"
  }
}

resource "aws_efs_mount_target" "efs-mount-private-sub-one" {
  file_system_id = aws_efs_file_system.Todo-eks-efs.id
  subnet_id      = var.private-subnet-one-id
  security_groups = ["${var.worker-node-sg-id}"]
}

resource "aws_efs_mount_target" "efs-mount-private-sub-two" {
  file_system_id = aws_efs_file_system.Todo-eks-efs.id
  subnet_id      = var.private-subnet-two-id
  security_groups = ["${var.worker-node-sg-id}"]
}