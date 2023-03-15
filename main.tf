provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_ec2_deploy" {
  ami           = "ami-02d0b04e8c50472ce"  # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  key_name      = "AWSstockholm"
  vpc_security_group_ids = ["sg-0cf66e1b712e421c3"]
  tags = {
    Name = "my-ec2-instance_deploy"
  }
}
