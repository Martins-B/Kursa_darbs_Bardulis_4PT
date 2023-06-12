provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "my_ec2_deploy" {
  ami           = "ami-01fe5e3a173900ade"
  instance_type = "t3.small"
  key_name      = "AWSstockholm"
  vpc_security_group_ids = ["sg-0cf66e1b712e421c3"]
  tags = {
    Name = "App deploy"
  }
}
resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.my_ec2_deploy]

  create_duration = "30s"
}
resource "null_resource" "execute_commands" {

  depends_on = [
        aws_instance.my_ec2_deploy,
        time_sleep.wait_30_seconds,
        ]

  provisioner "remote-exec" {
    inline = [
      var.pull_command,
      var.deploy_command
    ]

    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file(var.pem_file)
      host        = aws_instance.my_ec2_deploy.public_ip
    }
  }
}
variable "pem_file" {
  type = string
}
variable "pull_command" {
  type = string
}
variable "deploy_command" {
  type = string
}
