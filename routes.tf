resource "aws_route_table" "eks_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_ig.id
  }

  depends_on = [
    aws_vpc.eks_vpc
  ]
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.eks_subnet_one.id
  route_table_id = aws_route_table.eks_route_table.id

  depends_on = [
    aws_route_table.eks_route_table
  ]
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.eks_subnet_two.id
  route_table_id = aws_route_table.eks_route_table.id

  depends_on = [
    aws_route_table.eks_route_table
  ]
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.eks_subnet_three.id
  route_table_id = aws_route_table.eks_route_table.id

  depends_on = [
    aws_route_table.eks_route_table
  ]
}