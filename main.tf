provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-02d0b04e8c50472ce"  # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  key_name      = "AWSstockholm"
  security_groups = [
    "sg-0cf66e1b712e421c3"  
  ]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              EOF

  tags = {
    Name = "my-ec2-instance"
  }
}
