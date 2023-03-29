resource "aws_instance" "portfolio" {
  ami                    = var.AMIS[var.REGION]
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
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("portfolio.pem")
    host        = self.public_ip
  }
}
output "PublicIP" {
  value = aws_instance.portfolio.public_ip
}
