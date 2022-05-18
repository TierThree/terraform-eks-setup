resource "aws_security_group" "eks_endpoint_security_group" {
  name        = "eks_endpoint_security_group"
  description = "Security group to govern who can access the endpoints"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_vpc.eks_vpc
  ]
}

resource "aws_security_group" "eks_control_security_group" {
  name        = "eks_control_security_group"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_vpc.eks_vpc
  ]
}