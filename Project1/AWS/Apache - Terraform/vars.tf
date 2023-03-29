variable REGION {
  default = "eu-central-1"
}

variable ZONE1 {
  default = "eu-central-1a"
}

variable ZONE2 {
  default = "eu-central-1b"
}

variable AMIS {
  type = map
  default = {
    eu-central-1 = "ami-00ad2436e75246bba"
  }
}

variable USER {
  default = "ec2-user"
}

variable MYIP {
  default = "83.238.45.195/32"
}
