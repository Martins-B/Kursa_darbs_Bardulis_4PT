provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_ec2_deploy" {
  ami           = "ami-02d0b04e8c50472ce"  # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  key_name      = "AWSstockholm"
  security_groups = ["sg-0cf66e1b712e421c3"]
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user"
    ]
  }
  tags = {
    Name = "my-ec2-instance_deploy"
  }
}
