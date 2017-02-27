# tf-aws-sg-rr
Module to manage security groups

## Usage

```
# common security groups
module "common_sg" {
  source  = "../modules/tf-aws-sg-rr"
  name    = "common"
  envname = "${var.envname}"
  envtype = "${var.envtype}"
  vpc_id  = "${module.vpc.vpc_id}"

  cidr_rules = {
    icmp                   = [-1, -1, "icmp", "0.0.0.0/0"]
    ssh                    = [22, 22, "tcp", "10.10.10.10/32,${var.claranet_ips},${var.bastion_custom_ssh_cidrs}"]
    io_ipsec_office_http   = [80, 80, "tcp", "192.168.1.0/24,10.10.10.10/32"]
    io_ipsec_office_https  = [443, 443, "tcp", "192.168.1.0/24"]
    io_ipsec_office_8080   = [8080, 8080, "tcp", "192.168.1.0/24"]
    io-ipsec-office-docker = [5000, 5000, "tcp", "192.168.1.0/24"]
    consul_tcp             = [8301, 8302, "tcp", "${var.vpc_cidr}"]
    consul_udp             = [8301, 8302, "udp", "${var.vpc_cidr}"]
  }

  sgid_rules = {
    docker_from_bastions = [5000, 5000, "tcp", "${module.bastion_sg.security_group_id}"]
    docker_from_jenkins = [5000, 5000, "tcp", "${module.jenkins_sg.security_group_id}"]
  }

  sgid_rules_count = 2
}
```