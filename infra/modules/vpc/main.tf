resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge({ "Name" = var.name }, var.tags)
}

# --- Subnets ---
# Creates a public subnet in each specified Availability Zone
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true # Instances launched here get a public IP

  tags = merge({ "Name" = "${var.name}-public-subnet" }, var.tags)
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = merge({ "Name" = "${var.name}-private-subnet" }, var.tags)
}

# --- Internet Gateway ---
# Required for resources in public subnets to access the internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge({ "Name" = "${var.name}-igw" }, var.tags)
}

# --- Routing for Public Subnets ---
# Creates a route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # Route to the internet via the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge({ "Name" = "${var.name}-public-rt" }, var.tags)
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
