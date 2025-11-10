# Interpolation
locals {
  interpolation_input  = "Hello"
  interpolation_result = "${local.interpolation_input} world!"
  # Result: interpolation_result = "Hello world!"
}

output "interpolation" {
  value = local.interpolation_result
}

# Directive
variable "directive" {
  type    = string
  default = "world"
}

locals {
  directive_input  = "world"
  directive_output = "Hello %{if local.directive_input != ""}${local.directive_input}%{else}unknown%{endif}!"
  # Result: directive_output = "Hello world!"
}

output "directive" {
  value = local.directive_output
}

# Ternary
locals {
  ternary_input  = "world"
  ternary_local  = local.ternary_input == "" ? "unknown" : local.ternary_input
  ternary_result = "Hello ${local.ternary_local}!"
  # Result: ternary_result = "Hello world!"
}

locals {
  ternary_int_input  = "world"
  ternary_int_output = "Hello ${local.ternary_int_input == "" ? "unknown" : local.ternary_int_input}!"
  # Result: ternary_int_output = "Hello world!"
}

output "ternary" {
  value = local.ternary_result
}

output "ternary_with_interpolation" {
  value = local.ternary_int_output
}

# Arithmetic
locals {
  add      = 1 + 2 # 3
  subtract = 2 - 1 # 1
  multiply = 2 * 2 # 4
  divide   = 4 / 2 # 2
  modulo   = 5 % 2 # 1
}

output "arithmetic" {
  value = {
    add      = local.add
    subtract = local.subtract
    multiply = local.multiply
    divide   = local.divide
    modulo   = local.modulo
  }
}

# Logical Operators
locals {
  equal                 = 1 == 1 # true
  not_equal             = 1 != 2 # true
  greater_than          = 2 > 1  # true
  less_than             = 1 < 2  # true
  greater_than_or_equal = 2 >= 1 # true
  less_than_or_equal    = 1 <= 2 # true

  and = true && false # false
  or  = true || false # true (Terraform does not support short-circuit evaluation)
  not = !true         # false
}

output "logical_operators" {
  value = {
    equal                 = local.equal
    not_equal             = local.not_equal
    greater_than          = local.greater_than
    less_than             = local.less_than
    greater_than_or_equal = local.greater_than_or_equal
    less_than_or_equal    = local.less_than_or_equal
    and                   = local.and
    or                    = local.or
    not                   = local.not
  }
}
