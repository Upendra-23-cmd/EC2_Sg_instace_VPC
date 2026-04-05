terraform {
    required_version = ">=1.2"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    default_tags {
        tags = {
            Name = "ec2-setup"
            Enviroment = "horizontal-scaling"
        }
    }
}

resource "aws_security_group" "my_sg" {
    name = "my-sg"
    description = "security group for my instances"
    vpc_id = aws_vpc.cloud.id

    # INBOUND RULES
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    }

    # OUTBOUND RULES
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
    }


}

resource "aws_instance" "my-sg_instance" {
    ami = "ami-0ec10929233384c7f"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    
    root_block_device {
        volume_size = 8
        volume_type = "gp3"
    }
    tags = {
        Name = "my-sg-instance"
    }
  
}
