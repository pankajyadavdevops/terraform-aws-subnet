provider "aws" {
  region = "eu-west-1"
}

##-----------------------------------------------------------------------------
## Vpc Module call.
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "git@github.com:pankajyadavdevops/terraform-aws-vpc.git?ref=master"
  version     = "1.0.3"
  name        = "app"
  environment = "test"
  cidr_block  = "10.0.0.0/16"

}

##-----------------------------------------------------------------------------
## Subnet Module call.
##---------------------------------------------------------------------------
module "private-subnets" {
  source              = "./../../"
  name                = "app"
  environment         = "test"
  nat_gateway_enabled = true
  availability_zones  = ["eu-west-1a"]
  vpc_id              = module.vpc.vpc_id
  type                = "private"
  cidr_block          = module.vpc.vpc_cidr_block
  ipv6_cidr_block     = module.vpc.ipv6_cidr_block
  ipv4_private_cidrs  = ["10.0.3.0/24"]
  public_subnet_ids   = ["subnet-061b3xxxbe5d6", "subnet-xxxxxbb0922f"] # Use the output here
  enable_ipv6         = false
}
