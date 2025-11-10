variable "location" {
  type    = string
  default = "UK South"
}

variable "name" {
  type    = string
  default = "rg-demo"
}

output "name" {
  value = var.name
}