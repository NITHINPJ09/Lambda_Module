output "vpc_id"{
    value = data.aws_vpc.existing_vpc.id
}

output "private_subnets_id"{
    value = data.aws_subnets.private_subnets.ids
}

output "default_sg_id"{
    value = data.aws_security_group.default.id
}
