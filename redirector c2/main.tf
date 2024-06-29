
resource "aws_security_group" "redirector-ingress-all" {
  name = "redirector-allow-all"
  vpc_id = var.vpc_id
  ingress {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = 0
      to_port = 8888
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

resource "aws_instance" "redteam-c2-redirector" {
  ami           = "ami-0ffea00000f287d30"
  instance_type = "t2.micro"
  key_name = "ec2_key_pair"
  security_groups = [aws_security_group.redirector-ingress-all.id]
  private_ip = "${var.subnet_cidr_prefix}.110"
  subnet_id = var.subnet_id
  user_data = <<EOF
              #! /bin/bash
              sudo yum -y install socat
              echo "[Unit]" > /etc/systemd/system/redirector.service
              echo "Description=C2 Redirector Service" >> /etc/systemd/system/redirector.service 
              echo "" >> /etc/systemd/system/redirector.service 
              echo "[Service]" >> /etc/systemd/system/redirector.service 
              echo "User=ec2-user" >> /etc/systemd/system/redirector.service 
              echo "ExecStart=/usr/bin/sudo /usr/bin/socat TCP4-LISTEN:80,fork,reuseaddr TCP4:${var.caldera_public_ip}:8888" >> /etc/systemd/system/redirector.service 
              echo "" >> /etc/systemd/system/redirector.service 
              echo "[Install]" >> /etc/systemd/system/redirector.service 
              echo "WantedBy=multi-user.target" >> /etc/systemd/system/redirector.service 
              systemctl daemon-reload
              systemctl start redirector
              systemctl enable redirector
            EOF
  
  root_block_device {
    delete_on_termination = true
    volume_size           = 30
  }

  tags = {
    Name = "Red Team EC2 Redirector Machine - ${var.env}"
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