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
    eu-central-1 = "ami-0ec7f9846da6b0f61"
  }
}

variable USER {
  default = "ubuntu"
}

variable MYIP {
  default = "83.238.45.195/32"
}
