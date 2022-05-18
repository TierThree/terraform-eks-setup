resource "aws_vpc" "eks_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = tomap({
    Name = "eks_vpc",
    "kubernetes.io/cluster/eks_lab_cluster" = "shared",
  })
}

resource "aws_subnet" "eks_subnet_one" {
  vpc_id            = aws_vpc.eks_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "192.168.0.0/18"
  map_public_ip_on_launch = true

  depends_on = [
    aws_vpc.eks_vpc
  ]
}

resource "aws_subnet" "eks_subnet_two" {
  vpc_id            = aws_vpc.eks_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "192.168.64.0/18"
  map_public_ip_on_launch = true

  depends_on = [
    aws_vpc.eks_vpc
  ]
}

resource "aws_subnet" "eks_subnet_three" {
  vpc_id            = aws_vpc.eks_vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "192.168.128.0/18"
  map_public_ip_on_launch = true

  depends_on = [
    aws_vpc.eks_vpc
  ]
}

resource "aws_internet_gateway" "eks_ig" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks_internet_gateway"
  }
}

resource "aws_vpc_dhcp_options" "eks_dhcp_options" {
  domain_name = "us-east-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "eks_dhcp_options"
  }
}

resource "aws_vpc_endpoint" "sts" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.sts"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id            = aws_vpc.eks_vpc.id
  service_name      = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
  security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

  depends_on = [
    aws_vpc.eks_vpc,
    aws_subnet.eks_subnet_one,
    aws_subnet.eks_subnet_two,
    aws_subnet.eks_subnet_three,
    aws_security_group.eks_control_security_group,
    aws_security_group.eks_endpoint_security_group
  ]
}