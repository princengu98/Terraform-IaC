resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
  
}
resource "aws_subnet" "myapp-Pub-SN" {
    vpc_id = aws_vpc.myapp-vpc.id
    cidr_block = var.subnet_cidr_block[0].subnet_cidr_block
    availability_zone = var.AZ[0].AZ
    tags = {
        Name: "${var.env_prefix}-Pub-SN"
    }
}
resource "aws_subnet" "myapp-Priv-SN" {
    vpc_id = aws_vpc.myapp-vpc.id
    cidr_block = var.subnet_cidr_block[1].subnet_cidr_block
    availability_zone = var.AZ[1].AZ
    tags = {
        Name: "${var.env_prefix}-Priv-SN"
    }
}
resource "aws_internet_gateway" "myapp-IGW" {
    vpc_id = aws_vpc.myapp-vpc.id

    tags = {
        Name: "${var.env_prefix}-IGW"
    }
  
}
resource "aws_route_table" "myapp-RT" {
    vpc_id = aws_vpc.myapp-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-IGW.id
    }
    tags = {
        Name: "${var.env_prefix}-RT"
    }
}
resource "aws_route_table_association" "myapp-RT-Assoc-with-Pub_SN" {
    subnet_id = aws_subnet.myapp-Pub-SN.id
    route_table_id = aws_route_table.myapp-RT.id
  
}
resource "aws_security_group" "myapp-SG" {
    name = "myapp-SG"
    vpc_id = aws_vpc.myapp-vpc.id

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my-ip]
    }

    ingress  {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []

    }

    tags = {
        Name:  "${var.env_prefix}-SG"
    }
}

data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    /*filter {
      name = "Virtualization-type"
      values = ["hvm"]
    }*/
  
}
output "aws_ami_id" {
    value = data.aws_ami.latest-amazon-linux-image.id
  
}
output "EC2_public_ip" {
    value = aws_instance.myapp-server.public_ip 
  
}

resource "aws_key_pair" "myapp-ssh-key" {
    key_name = "server-key"
    public_key = var.public_key-pair
  
}

resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type

    subnet_id = aws_subnet.myapp-Pub-SN.id
    vpc_security_group_ids = [aws_security_group.myapp-SG.id]
    availability_zone = var.AZ[0].AZ

    associate_public_ip_address = true
    key_name = aws_key_pair.myapp-ssh-key.key_name

    user_data = file("entry_script.sh")

    tags = {
        Name = "${var.env_prefix}-server"
    }


  
}
