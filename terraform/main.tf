module "Network-Module" {
  source="./Network-Module"
  vpc-name = var.vpc-name
  region = var.region
  cluster-name = var.cluster-name
  key-pair = var.key-pair
}

module "EKS-Module" {
  source = "./EKS-Module"
  cluster-name = var.cluster-name
  private-subnets = [module.Network-Module.private-one-id,module.Network-Module.private-two-id]
  vpc-id = module.Network-Module.vpc-id
  vpc-cidr = module.Network-Module.vpc-cidr
  key-pair = module.Network-Module.key-pair
  available-zone = module.Network-Module.available-zone
  bastion-sg = module.Bastion-Module.bastion-sg-ssh
}

module "EFS-Module" {
  source = "./EFS-Module"
  private-subnet-one-id = module.Network-Module.private-one-id
  private-subnet-two-id = module.Network-Module.private-two-id
  worker-node-sg-id = module.EKS-Module.worker-node-sg-id
}

module "Bastion-Module" {
  source = "./Bastion-Module"
  vpc-id = module.Network-Module.vpc-id
  ami-bastion = var.ami-bastion
  key-name = module.Network-Module.key-pair
  public-subnets = [module.Network-Module.public-one-id,module.Network-Module.public-two-id]
}