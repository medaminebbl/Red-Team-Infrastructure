variable "env" {
    type = string
    default = "dev"
}

variable "subnet_cidr_prefix" {
    type = string
    default = "172.16.10"
}

variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

