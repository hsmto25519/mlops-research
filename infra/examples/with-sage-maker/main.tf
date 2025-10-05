data "http" "my_ip" {
  url = "https://ifconfig.me/ip" # Simple endpoint that returns just the IP
}

module "vpc" {
  source = "../modules/vpc"

  name                = "sagemaker-use-vpc"
  vpc_cidr            = "10.100.0.0/16"
  public_subnet_cidr  = "10.100.0.0/24"
  private_subnet_cidr = "10.100.1.0/24"
  tags                = local.tags
}

module "sg" {
  source = "../modules/sg"

  name        = "sagemaker-use-sg"
  description = "Security group for SageMaker use"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags

  ingress_rules = [
    {
      description = "Allow SSH from my IP"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "${chomp(data.http.my_ip.response_body)}/32"
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]
}

module "ml_data_store" {
  source = "../modules/efs"

  name               = "my-efs"
  subnet_id          = module.vpc.private_subnet_id
  security_group_ids = [module.sg.id]
  tags               = local.tags
}

module "sagemaker_role" {
  source = "../modules/iam-assume-role"

  name                 = "role-sagemaker-use"
  service_principal    = "sagemaker.amazonaws.com"
  aws_managed_policies = []
}


module "ml_platform" {
  source = "../modules/sagemaker"

  domain_name          = "sagemaker-use-domain"
  auth_mode            = "IAM"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = [module.vpc.public_subnet_id]
  security_group_ids   = [module.sg.id]
  efs_file_system_id   = module.ml_data_store.id
  efs_file_system_path = "/sagemaker"
  execution_role_arn   = module.sagemaker_role.arn
  user_profile_list    = ["user1", "user2"]
  tags                 = local.tags
}

module "image_repository" {
  source = "../modules/ecr"

  name = "my-ecr-repo"
  tags = local.tags
}
