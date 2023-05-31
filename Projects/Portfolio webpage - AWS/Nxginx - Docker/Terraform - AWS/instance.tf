resource "aws_instance" "portfolio" {
  ami                    = var.AMIS-Ubuntu[var.REGION]
  instance_type          = "t2.micro"
  key_name               = "portfolio"
  vpc_security_group_ids = ["portfolio-stack-sg"]
  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 8
  }
  tags = {
    Name = "portfolio"
  }

  provisioner "file" {
    source      = "docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/docker.sh",
      "sudo /tmp/docker.sh"
    ]
  }

  connection {
    user        = var.USER-Ubuntu
    private_key = file("portfolio.pem")
    host        = self.public_ip
  }
}
output "PublicIP" {
  value = aws_instance.portfolio.public_ip
}
