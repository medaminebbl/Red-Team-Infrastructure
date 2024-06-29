resource "aws_vpc" "redteam_vpc" {
  cidr_block = "${var.cidr_prefix}.0.0/16"
  tags = {
    Name = "Red Team VPC"
    Workspace = "MART"
  }
}

resource "aws_internet_gateway" "redteam_gw" {
  vpc_id = aws_vpc.redteam_vpc.id
  tags = {
    Name = "Red Team Default Gateway - ${var.env}"
    Workspace = "MART"
    Environment = var.env
  }
}

resource "aws_subnet" "redteam_subnet" {
  vpc_id            = aws_vpc.redteam_vpc.id
  cidr_block        = "${var.cidr_prefix}.10.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.redteam_gw]

  tags = {
    Name = "Main Red Team Subnet - ${var.env}"
    Workspace = "MART"
    Environment = var.env
  }
}
resource "aws_route_table" "redteam-route-table" {
  vpc_id = aws_vpc.redteam_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.redteam_gw.id
  }
  tags = {
    Name = "redteam-route-table"
    Workplace = "MART"
    Environment = var.env
  }
}
resource "aws_route_table_association" "redteam-subnet-association" {
  subnet_id      = aws_subnet.redteam_subnet.id
  route_table_id = aws_route_table.redteam-route-table.id
}
