resource "aws_eks_node_group" "eks_lab_node_group" {
  cluster_name    = aws_eks_cluster.eks_lab.name
  node_group_name = "eks_lab_nodes"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_lab-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_lab-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_lab-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_EKSNodeClusterPolicy,
    aws_eks_cluster.eks_lab,
    aws_security_group.eks_control_security_group
  ]
}