# resource "aws_launch_template" "Todo-eks-ng-ltemp" {

#   name = "Todo-eks-ng-ltemp"
#   instance_type = "t2.medium"
#   key_name = var.key-pair

#   block_device_mappings {
#     device_name = "/dev/sda1"
#     ebs {
#       volume_size = 5
#       volume_type = "gp2"
#       delete_on_termination = true
#     }
#   }

#   vpc_security_group_ids = [aws_security_group.worker-node-sg.id,aws_eks_cluster.Todo-eks.vpc_config[0].cluster_security_group_id]

#   tag_specifications {
#     resource_type = "instance"
#     tags = { 
#       Name = "Todo-eks-ng-lt"
#     }
#   }

#   network_interfaces {
#     # associate_carrier_ip_address = true
#     security_groups = [aws_security_group.worker-node-sg.id,
#                        aws_security_group.master-node-sg.id,
#                        aws_eks_cluster.Todo-eks.vpc_config[0].cluster_security_group_id]
#   }

#   placement {
#     availability_zone = var.available-zone
#   }
# }
