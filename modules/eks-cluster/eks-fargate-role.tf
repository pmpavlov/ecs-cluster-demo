resource "aws_iam_role" "eks-fargate-role" {
  name               = "devops-eks-fargate-role"
  assume_role_policy = data.aws_iam_policy_document.eks-fargate-profile.json
}

resource "aws_iam_role_policy_attachment" "eks-fargate-profile" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-role.name
}

data "aws_iam_policy_document" "eks-fargate-profile" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "eks-fargate-pods.amazonaws.com"
      ]
    }
  }
}

