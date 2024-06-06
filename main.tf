module "vpc" {
  source  = "./modules/vpc"
}

module "ecs-cluster" {
  source  = "./modules/ecs-cluster"
  vpc_id  = module.vpc.vpc_id
  public_subnet_1 = module.vpc.public_subnet_1
  public_subnet_2 = module.vpc.public_subnet_2
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
  db_subnet_1 = module.vpc.db_subnet_1
  db_subnet_2 = module.vpc.db_subnet_2
  environment = var.environment
  name = var.name
  container_port = var.container_port
}

#module "eks-cluster" {
#  source  = "./modules/eks-cluster"
#  vpc_id  = module.vpc.vpc_id
#  public_subnet_1 = module.vpc.public_subnet_1
#  public_subnet_2 = module.vpc.public_subnet_2
#  private_subnet_1 = module.vpc.private_subnet_1
#  private_subnet_2 = module.vpc.private_subnet_2
#  db_subnet_1 = module.vpc.db_subnet_1
#  db_subnet_2 = module.vpc.db_subnet_2
#}

