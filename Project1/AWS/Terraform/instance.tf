resource "aws_instance" "portfolio" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  key_name               = "portfolio"
  tags = {
    Name = "portfolio"
  }
}

output "PublicIP" {
  value = aws_instance.portfolio.public_ip
}
