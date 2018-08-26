variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "aleksKeys"
}

variable "network_address_space" {
  default = "172.13.2.0/16"
}

variable "subnet1_address_space" {
  default = "172.13.2.0/24"
}

variable "subnet2.address_space" {
  default = "172.13.3.0/24"
}

provider "aws" {
  region = "us-west-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_availability_zones" "avaliable" {}


