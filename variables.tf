variable "name" {
  type    = string
  default = "cka"
}
variable "env" {
  type    = string
  default = "practice"
}
variable "vpc_cidr_block" {
  type    = string
  default = "192.168.0.0/24"
}
variable "public_subnets" {
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
  default = {
    "2a" = {
      availability_zone = "ap-northeast-2a"
      cidr_block        = "192.168.0.0/27"
    }
  }
}