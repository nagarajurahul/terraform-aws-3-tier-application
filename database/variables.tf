variable "vpc_id"{
    
}
variable "username" {

}
variable "password"{
    description = "RDS Master password"
    sensitive   = true
}
variable "instance_class"{
    default = "db.t3.micro"
}
variable "allocated_storage"{
    default = 10
}
variable "skip_final_snapshot" {
    default = true
}
variable "db_name" {
    default = "my-db"
}
variable "identifier" {
    default = "my-db"
}
variable "subnet_ids"{
    type    = list(string)
}
variable "source_security_group_id" {
  
}