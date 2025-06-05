variable "instance-type"{
    type = "string"

    default = "t2.micro"
}

variable "hibernation-mode"{
    type = bool

    default = false
}