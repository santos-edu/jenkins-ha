provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name  = "jenkins-agent"
  ami_id         = "ami-019d082215d693b79"
  instance_type  = "t2.micro"
  key_name       = "jenkins"
  subnet_ids     = data.aws_subnets.default.ids
  instance_count = 1
}
