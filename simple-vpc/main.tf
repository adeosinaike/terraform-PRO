##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}


##CREATE A VPC####

resource "aws_vpc" "simple_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "simple_vpc"
  }
}

resource "aws_internet_gateway" "simple_igw" {
  vpc_id = aws_vpc.simple_vpc.id

}

##################################################################################
# RESOURCES
##################################################################################


resource "aws_subnet" "public_subnet_a" {
  cidr_block              = var.subnet_cidr_block[0]
  vpc_id                  = aws_vpc.simple_vpc.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_a" {
  cidr_block              = var.subnet_cidr_block[1]
  vpc_id                  = aws_vpc.simple_vpc.id
  map_public_ip_on_launch = false
}

resource "aws_subnet" "database_subnet_a" {
  cidr_block              = var.subnet_cidr_block[2]
  vpc_id                  = aws_vpc.simple_vpc.id
  map_public_ip_on_launch = false
}



# ROUTING #
resource "aws_route_table" "simple_rtb" {
  vpc_id = aws_vpc.simple_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.simple_igw.id
  }
}

resource "aws_route_table_association" "simple-rta-subnet1" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.simple_rtb.id
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "web-server-sg" {
  name   = "web-server-sg"
  vpc_id = aws_vpc.simple_vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# INSTANCES #
resource "aws_instance" "web_server" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Norlerge Technologies</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}

