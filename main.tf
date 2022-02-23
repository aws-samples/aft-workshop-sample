provider "aws" {
  region = var.ct_home_region
}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_iam_role" "cloud9-aft-role" {
  name = "cloud9-aft-role-${random_id.id.hex}"
  path = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "aws_iam_instance_profile" "cloud9-aft-profile" {
  name = var.c9_instance_profile
  role = aws_iam_role.cloud9-aft-role.name
}

resource "aws_cloud9_environment_ec2" "cloud9-aft" {
  name          = var.c9_instance_name
  instance_type = "t2.small"
  subnet_id     = local.vpc.is_use_aft_vpc ? tolist(data.aws_subnet_ids.aft_public_subnet_01[local.vpc.index].ids)[0] : null
}