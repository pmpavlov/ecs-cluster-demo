resource "aws_eks_cluster" "devops-eks-cluster" {
 name = "devops-eks-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  endpoint_private_access = false
  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  subnet_ids = [var.private_subnet_1, var.private_subnet_2]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}

resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name           = aws_eks_cluster.devops-eks-cluster.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.eks-fargate-role.arn

  subnet_ids = [var.private_subnet_1, var.private_subnet_2]

  selector {
    namespace = "kube-system"
  }
}
