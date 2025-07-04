variable "vpc_id"{
    
}
variable "env" {

}
variable "owner"{  

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
    default = false
}
variable "db_name" {
    default = "mydb"
}
variable "identifier" {
    default = "mydb"
}
variable "subnet_ids"{
    type    = list(string)
}
variable "source_security_group_id" {
  
}
variable "deletion_protection" {
    default = true
}
variable "rds_multi_az" {
    default = false
}
variable "secret_id" {
  
}
variable "secret_arn" {
  
}
variable "secret_version_id" {
  
}