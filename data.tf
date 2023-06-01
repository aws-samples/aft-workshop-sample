data "aws_vpc" "aft_management_vpc" {
  count    = var.use_aft_vpc ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["aft-management-vpc"]
  }
}

data "aws_subnet" "aft_public_subnet_01" {
  count    = var.use_aft_vpc ? 1 : 0
  vpc_id   = data.aws_vpc.aft_management_vpc[count.index].id
  filter {
    name   = "tag:Name"
    values = ["aft-vpc-public-subnet-01"]
  }
}

data "aws_instance" "cloud9-instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.cloud9-aft.id]
  }
}