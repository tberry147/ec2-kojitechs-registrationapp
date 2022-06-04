
data "aws_availability_zones" "az" {
  state = "available"

}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }
}

data "aws_key_pair" "mykey" {
  key_name = "Key"
}


data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["kojitechs_vpc"]
  }
}

data "aws_subnet_ids" "private_subnet" {
  filter {

    name   = "tag:Name"
    values = ["private_subnet_*"]
  }
  vpc_id = local.vpc_id
}

data "aws_subnet_ids" "public_subnet" {
  filter {

    name   = "tag:Name"
    values = ["public_subnet_*"]
  }
  vpc_id = local.vpc_id
}

data "aws_subnet_ids" "database_subnet" {
  filter {

    name   = "tag:Name"
    values = ["database_subnet_*"]
  }
  vpc_id = local.vpc_id
}

data "aws_subnet" "private_subnet" {
  for_each = data.aws_subnet_ids.private_subnet.ids
  id       = each.value
}

data "aws_subnet" "public_subnet" {
  for_each = data.aws_subnet_ids.public_subnet.ids
  id       = each.value
}

data "aws_subnet" "database_subnet" {
  for_each = data.aws_subnet_ids.database_subnet.ids
  id       = each.value
}