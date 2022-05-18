resource "aws_eks_cluster" "eks_lab" {
  name     = "eks_lab_cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids              = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  }

  depends_on = [
    aws_vpc.eks_vpc,
    aws_iam_role.eks_role,
    aws_iam_role_policy_attachment.eks_EKSClusterPolicy,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_endpoint_security_group,
    aws_security_group.eks_control_security_group,
    aws_vpc_endpoint.sts,
    aws_vpc_endpoint.s3,
    aws_vpc_endpoint.ecr_dkr,
    aws_vpc_endpoint.ecr_api,
    aws_vpc_endpoint.ec2,
    aws_vpc_endpoint.logs,
    aws_route_table.eks_route_table,
    aws_route_table_association.a,
    aws_route_table_association.b,
    aws_route_table_association.c
  ]
}