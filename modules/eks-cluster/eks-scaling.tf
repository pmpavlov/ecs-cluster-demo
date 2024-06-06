resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.devops-eks-cluster.name
  node_group_name = "devops-worker-nodes"
  node_role_arn  = aws_iam_role.eks-worker-nodes.arn
  subnet_ids   = [var.private_subnet_1, var.private_subnet_2]
  instance_types = ["t3.micro"]
 
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

