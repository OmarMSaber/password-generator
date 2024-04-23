variable "region" {
  type = string
}

variable "vpc-name" {
    type = string
}

variable "cluster-name" {
    type = string
}

variable "vpc-cidr" { 
    type = string
    default = "10.0.0.0/16"
}

variable "public-subnet1-cidr" { 
    type = string
    default = "10.0.1.0/24"
}
variable "public-subnet2-cidr" {
    type = string
    default = "10.0.2.0/24"
 }

variable "private-subnet1-cidr" {
    type = string
    default = "10.0.3.0/24"
 }
variable "private-subnet2-cidr" { 
    type = string
    default = "10.0.4.0/24"
}

variable "key-pair" {}
