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

module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = data.aws_subnets.default.ids
  ami_id        = "ami-0cff8e260aead7855"
  instance_type = "t2.micro"
  key_name      = "jenkins"
  environment   = "dev"
  vpc_id        = data.aws_vpc.default.id
}