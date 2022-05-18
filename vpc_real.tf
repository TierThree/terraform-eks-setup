# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_vpc" "eks_vpc" {
#   cidr_block = "192.168.0.0/16"

#   tags = tomap({
#     Name = "eks_vpc",
#     "kubernetes.io/cluster/eks_lab_cluster" = "shared",
#   })
# }

# resource "aws_subnet" "eks_subnet_one" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   availability_zone = "us-east-1a"
#   cidr_block        = "192.168.0.0/18"
#   map_public_ip_on_launch = true

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_subnet" "eks_subnet_two" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   availability_zone = "us-east-1b"
#   cidr_block        = "192.168.64.0/18"
#   map_public_ip_on_launch = true

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_subnet" "eks_subnet_three" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   availability_zone = "us-east-1c"
#   cidr_block        = "192.168.128.0/18"
#   map_public_ip_on_launch = true

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_internet_gateway" "eks_ig" {
#   vpc_id = aws_vpc.eks_vpc.id

#   tags = {
#     Name = "eks_internet_gateway"
#   }
# }

# resource "aws_vpc_dhcp_options" "eks_dhcp_options" {
#   domain_name = "us-east-1.compute.internal"
#   domain_name_servers = ["AmazonProvidedDNS"]

#   tags = {
#     Name = "eks_dhcp_options"
#   }
# }

# resource "aws_security_group" "eks_endpoint_security_group" {
#   name        = "eks_endpoint_security_group"
#   description = "Security group to govern who can access the endpoints"
#   vpc_id      = aws_vpc.eks_vpc.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = ["192.168.0.0/16"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_security_group" "eks_control_security_group" {
#   name        = "eks_control_security_group"
#   description = "Cluster communication with worker nodes"
#   vpc_id      = aws_vpc.eks_vpc.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_vpc_endpoint" "sts" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.sts"
#   vpc_endpoint_type = "Interface"

#   subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_vpc_endpoint" "s3" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.s3"
#   vpc_endpoint_type = "Gateway"

#   #subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   #security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_vpc_endpoint" "ecr_dkr" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.ecr.dkr"
#   vpc_endpoint_type = "Interface"

#   subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.ecr.api"
#   vpc_endpoint_type = "Interface"

#   subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_vpc_endpoint" "ec2" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.ec2"
#   vpc_endpoint_type = "Interface"

#   subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_vpc_endpoint" "logs" {
#   vpc_id            = aws_vpc.eks_vpc.id
#   service_name      = "com.amazonaws.us-east-1.logs"
#   vpc_endpoint_type = "Interface"

#   subnet_ids         = [aws_subnet.eks_subnet_one.id, aws_subnet.eks_subnet_two.id, aws_subnet.eks_subnet_three.id]
#   security_group_ids = [aws_security_group.eks_endpoint_security_group.id]

#   depends_on = [
#     aws_vpc.eks_vpc,
#     aws_subnet.eks_subnet_one,
#     aws_subnet.eks_subnet_two,
#     aws_subnet.eks_subnet_three,
#     aws_security_group.eks_control_security_group,
#     aws_security_group.eks_endpoint_security_group
#   ]
# }

# resource "aws_route_table" "eks_route_table" {
#   vpc_id = aws_vpc.eks_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.eks_ig.id
#   }

#   depends_on = [
#     aws_vpc.eks_vpc
#   ]
# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.eks_subnet_one.id
#   route_table_id = aws_route_table.eks_route_table.id

#   depends_on = [
#     aws_route_table.eks_route_table
#   ]
# }

# resource "aws_route_table_association" "b" {
#   subnet_id      = aws_subnet.eks_subnet_two.id
#   route_table_id = aws_route_table.eks_route_table.id

#   depends_on = [
#     aws_route_table.eks_route_table
#   ]
# }

# resource "aws_route_table_association" "c" {
#   subnet_id      = aws_subnet.eks_subnet_three.id
#   route_table_id = aws_route_table.eks_route_table.id

#   depends_on = [
#     aws_route_table.eks_route_table
#   ]
# }