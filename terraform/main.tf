provider "aws" {
  region = var.region
}

module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "security" {
  source       = "./modules/security"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
  tags         = var.tags
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "jenkins_ec2" {
  source            = "./modules/jenkins_ec2"
  vpc_id            = module.networking.vpc_id
  subnet_id         = module.networking.public_subnet_ids[0]
  instance_profile  = module.iam.ec2_instance_profile
  project_name      = var.project_name
  environment       = var.environment
  public_key_path   = "~/.ssh/id_rsa.pub"
  tags              = var.tags
}
