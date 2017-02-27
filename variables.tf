variable "name" {}
variable "envname" {}
variable "envtype" {}
variable "vpc_id" {}

variable "egress" {
  default = true
}

variable "cidr_rules" {
  type    = "map"
  default = {}
}

variable "sgid_rules" {
  type    = "map"
  default = {}
}

# this is here because it is expected that sgid_rules will reference
# computed values (like `aws_security_group.sg.id`) and it is currently
# not possible to interpolate that in count
variable "sgid_rules_count" {
  default = 0
}
