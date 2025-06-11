variable owner{

}
variable env{

}
variable "vpc_id" {
  
}
variable "subnet_ids" {
    type = list(string)
}
variable "username" {
  
}
variable "password" {
  
}
variable skip_final_snapshot{
    default = false
}
variable "deletion_protection" {
    default = true
}
variable "rds_multi_az" {
    default = false
}
variable "backend_port" {
  default = 3000
}
variable "backend_security_group_id" {
  
}