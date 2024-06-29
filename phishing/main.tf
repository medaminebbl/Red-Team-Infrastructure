
resource "aws_security_group" "phishing-ingress-all" {
  name = "phishing-allow-all"
  vpc_id = var.vpc_id
  ingress {
    /* SSH incoming */
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    /* HTTP incoming */
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    /* HTTPS incoming */
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    /* GoPhish Admin Panel incoming */
    from_port   = 3333
    to_port     = 3333
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    /* Evilginx Nameserver incoming */
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "gophish" {
  ami           = "ami-0ffea00000f287d30"
  instance_type = "t2.micro"
  key_name = "ec2_key_pair"
  security_groups = [aws_security_group.phishing-ingress-all.id]
  private_ip = "${var.subnet_cidr_prefix}.120"
  subnet_id = var.subnet_id
  user_data = file("${path.module}/gophish-machine-config.yml")

  root_block_device {
    delete_on_termination = true
    volume_size           = 30
  }

  tags = {
    Name = "Red Team EC2 Machine - ${var.env}"
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

/*
data "template_file" "evilginx_user_data" {
  template = file("${path.module}/evilginx-machine-config.yml")

  vars = {
    domain = "linkedin.tk"
  }

}*/

resource "aws_instance" "evilginx" {
  ami           = "ami-0ffea00000f287d30"
  instance_type = "t2.micro"
  key_name = "ec2_key_pair"
  security_groups = [aws_security_group.phishing-ingress-all.id]
  private_ip = "${var.subnet_cidr_prefix}.130"
  subnet_id = var.subnet_id
  #user_data_base64 = base64encode(data.template_file.evilginx_user_data.rendered)
  user_data = file("${path.module}/evilginx-machine-config.yml")
  root_block_device {
    delete_on_termination = true
    volume_size           = 30
  }

  tags = {
    Name = "Red Team EC2 Machine - ${var.env}"
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

#You can update the config with remote_exec using:
# printf "config domain linkedin.tk\nconfig ip 22.22.22.22\nq" | sudo evilginx >> /tmp/init.log