variable "name_prefix" {
  type = string
}

variable "ami_id" {
  type    = string
  default = "ami-0c2b8ca1dad447f8a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}
