# Creating for 1 IAM-Group
resource "aws_iam_group" "GL_Group" {
  name = "GL_Group"
  path = "/system/"
}
# Creating for 3 IAM-User
resource "aws_iam_user" "GL_User" {
  name = element(var.iam_user, count.index)
  count = length(var.iam_user)
  path = "/system/"
}
# Creating for access key for each User
resource "aws_iam_access_key" "user_access_key" {
  user = element(var.iam_user, count.index)
  count = length(var.iam_user)
}

# Assigning users into GL-Group
resource "aws_iam_group_membership" "group_assign" {
  name = "iamgroup"
  users = var.iam_user
  group = aws_iam_group.GL_Group.name
}

#Assigning Policy into GL-Group

resource "aws_iam_group_policy" "S3_FullAccess_policy" {
  name  = "S3_FullAccess_policy"
  group = aws_iam_group.GL_Group.name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        },
      ]
  })
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "FirstVM" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}

/* ebs and load balancer and auto scaling  */