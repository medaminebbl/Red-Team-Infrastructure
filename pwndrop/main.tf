resource "aws_security_group" "redteam-ingress-all" {
  name = "pwn-drop-allow-all-sg"
  vpc_id = var.vpc_id
  ingress {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = 0
      to_port = 443
      protocol = "tcp"
  }
  # Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "pwn_drop" {
  ami           = "ami-0ffea00000f287d30"
  instance_type = "t2.micro"
  key_name = "ec2_key_pair"
  security_groups = [aws_security_group.pwn_drop-ingress-all.id]
  private_ip = "${var.subnet_cidr_prefix}.100"
  subnet_id = var.subnet_id
  user_data = file("${path.module}/pwndropconf.yml")

  root_block_device {
    delete_on_termination = true
    volume_size           = 30
  }

  tags = {
    Name = "Pwn drop EC2 machine - ${var.env}"
    Workspace = "MART"
    Environment = var.env
  }
  
  credit_specification {
    cpu_credits = "standard"
  }

  lifecycle {
    ignore_changes = [
      security_groups,
    ]
  }
}


