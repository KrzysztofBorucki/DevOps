resource "aws_instance" "wordpress" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  key_name               = "wordpress"
  vpc_security_group_ids = ["wordpress-stack-sg"]
  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 8
  }
  tags = {
    Name = "wordpress"
  }

  provisioner "file" {
    source      = "wordpress.sh"
    destination = "/tmp/wordpress.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/wordpress.sh",
      "sudo /tmp/wordpress.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("wordpress.pem")
    host        = self.public_ip
  }
}
output "PublicIP" {
  value = aws_instance.wordpress.public_ip
}
