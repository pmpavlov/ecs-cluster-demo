data "aws_availability_zones" "available" {
  state = "available"
}

# Create a VPC
resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
    Name = "eks-vpc"
  }
}

#Create Internet GateWay 
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "eks-igw"
  }
}

# Create public subnet in first AZ
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1a"
  }
}

# Create private subnet in first AZ
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_eip" "eip_nat_1" {
  vpc   = true
  tags = {
    Name = "eip-nat-public-1"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.eip_nat_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

resource "aws_route_table" "prv_rt_1" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_1.id
  }
}

resource "aws_route_table_association" "prv_1a" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.prv_rt_1.id
}

# Create database subnet in first AZ
resource "aws_subnet" "db_subnet_1" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "db-subnet-1a"
  }
}

# Create public subnet in second AZ
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2b"
  }
}

# Create private subnet in second AZ
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "private-subnet-2b"
  }
}

resource "aws_eip" "nat_2" {
  vpc   = true
  tags = {
    Name = "eip-nat-public-2"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "ngw_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
}

resource "aws_route_table" "prv_rt_2" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_2.id
  }
}

resource "aws_route_table_association" "prv_1b" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.prv_rt_2.id
}

# Create database subnet in second AZ
resource "aws_subnet" "db_subnet_2" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "db-subnet-2b"
  }
}

#Create Pubiic RT
resource "aws_route_table" "eks-public-rt" {
  vpc_id = aws_vpc.eks-vpc.id
  
  route {
      //associated subnet can reach everywhere
      cidr_block = "0.0.0.0/0" 
      //RT uses this IGW to reach internet
      gateway_id = aws_internet_gateway.eks-igw.id
  }
  tags = {
      Name = "eks-public-rt"
 }
}

resource "aws_route_table_association" "eks-rta-public-subnet-1a"{
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.eks-public-rt.id
}

resource "aws_route_table_association" "eks-rta-public-subnet-1b"{
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.eks-public-rt.id
}

