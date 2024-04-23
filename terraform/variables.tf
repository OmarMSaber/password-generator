variable "region" {
  type = string
  default = "eu-west-1"
}
variable "profile" {
  type = string
  default = "terraform"
}

variable "vpc-name" {
    type = string
    description = "EKS Cluster VPC Name"
    default = "Todo-eks-vpc"
}

variable "cluster-name" {
  type = string
  default = "Todo-eks"
}

variable "key-pair" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE6NuY9GB/NGa95bv4FFlRfbA20kEI90OmkMlGXLwtGiMEZNmX8GCpNvnHgaumiw54swI28KBsdX/YgxI8RGtZ+PY0JB8w1960GlgoZ95+u6QDtmb7MhDSl0FqdYSeGKS3zvCnE981/3xPTGG/EIuMIGuXOOIVNHd9QJxLiLt2W/6PAyzYGsFLx16B+MHukUwBLmGJ94SNFdipx+o8+6BzxeH+an1CorYb+9/MrrQpzRj1nu+8aja9bAuxdpQ6b77XKWTQTbLmJ23sxYM7brWuf3jISvWG/quQ8nghd+axTIa+D01ojfSavUcnTNuX+soDw9GdLDIMkw1ONKo7NyfPtedIYSFL3UmROvOmtnzj6h9/LwPvQM2WHAkRlghmVwnonh9WIqAhNrl4aMXwhCKwYBOH+UzEbQD4wVSiaO8eK28uBwqBbUbTTzREKCgbK4ImlCnfjqlZ0MjuT1pQvuTt3n/H2whfARH/brETqoeCkJnaOInH3w82+HfxgQ2iQa0= ahmedabdelnabi@ahmeds-MacBook-Pro.local"
}

variable "ami-bastion" {
  type = string
  default = "ami-0316939d36d601217"
}