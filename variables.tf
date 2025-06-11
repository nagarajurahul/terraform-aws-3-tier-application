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
variable "backend_port" {
  default = 3000
}