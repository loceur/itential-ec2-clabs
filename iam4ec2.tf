data aws_iam_policy_document "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data aws_iam_policy_document "s3_read_access" {
  statement {
    actions = ["s3:Get*", "s3:List*"]

    resources = ["arn:aws:s3:::*"]
  }
}

data "aws_iam_role" "ec2_iam_role" {
  name = "ec2_iam_role"

}


data "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
}
