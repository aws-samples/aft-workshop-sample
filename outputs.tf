output "cloud9_ide" {
  value = "https://${var.ct_home_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.cloud9-aft.id}?region=${var.ct_home_region}"
}

output "cloud9_instance_id" {
  value = data.aws_instance.cloud9-instance.id
}

output "cloud9_instance_profile" {
  value = aws_iam_instance_profile.cloud9-aft-profile.arn
}