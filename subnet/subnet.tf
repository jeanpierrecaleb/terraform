#module subnet

terraform {
  required_version = ">=1.5"
}


# Public Subnet
resource "aws_subnet" "subnet-nb" {
  # Number of public subnet is defined in vars
  count  = length(var.public_cidrs)
  vpc_id = var.my_vpc_id
  ## cidr_block = var.subnet-cidr_block
  cidr_block = element(var.public_cidrs, count.index)
  # Zone de disponibilite
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# define the instance wanted
# ...

# Export the ids
output "subnet_ids" {
  description = "List of subnet IDs"
  value       = aws_subnet.subnet-nb[*].id
}


#Definition internet gateway
resource "aws_internet_gateway" "igw" {
 vpc_id = var.my_vpc_id
 
 tags = {
   Name = "IG My-VPC"
 }
}

#Creation specified route table
resource "aws_route_table" "second_rt" {
 vpc_id = var.my_vpc_id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}

# explicite association des subnets au igw via route
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_cidrs)
 subnet_id      = element(aws_subnet.subnet-nb[*].id, count.index)
 route_table_id = aws_route_table.second_rt.id
}

