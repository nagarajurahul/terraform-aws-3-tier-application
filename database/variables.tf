variable "username" {

}
variable "password"{

}

variable "instance_class"{
    default = "db.t3.micro"
}
variable "allocated_storage"{
    default = 10
}

variable "db_name" {
    default = "my_db"
}

variable "subnet_ids"{
    type    = list(string)
}