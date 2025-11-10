# Value Types
variable "string" {
  type    = string
  default = "Hello, world!"
}

variable "number" {
  type    = number
  default = 42
}

variable "bool" {
  type    = bool
  default = true
}

# Collection Types
variable "list" {
  type    = list(string)
  default = ["Hello", "world!"]
}

locals {
  list_result = var.list[1]
  # Result: list_result = "world!"
}

variable "map" {
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

locals {
  map_result = var.map["key1"]
  # Result: map_result = "value1"
}

variable "set" {
  type    = set(string)
  default = ["Hello", "world!"]
}

# Complex Types
variable "object" {
  type = object({
    key1 = string
    key2 = number
    key3 = object({
      name = optional(string, "Terraform")
    })
  })
  default = {
    key1 = "Hello, world!"
    key2 = 42
    key3 = {
      name = "Training"
    }
  }
}

locals {
  object_result = var.object.key1
  # Result: object_result = "Hello, world!"
}

variable "tuple" {
  type = tuple([string, number, object({
    name = string
  })])
  default = ["Hello", 42, { name = "world!" }]
}

locals {
  tuple_result = var.tuple[2].name
  # Result: tuple_result = "world!"
}

# Dynamic Types
variable "dynamic" {
  type    = any
  default = "Hello, world!"
}

variable "dynamic_list" {
  type    = list(any)
  default = ["Hello", "World!"] # Elements must the be same type
}
