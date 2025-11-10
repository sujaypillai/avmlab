# Map for
locals {
  for_map_input = {
    key1 = "hello"
    key2 = "world"
  }
  for_map_result = { for key, value in local.for_map_input : key => upper(value) }
  # Result: map_result = { key1 = "HELLO", key2 = "WORLD" }
}

# List for
locals {
  for_list_input = [
    "hello",
    "world"
  ]
  for_list_result = [for value in local.for_list_input : upper(value)]
  # Result: list_result = ["HELLO", "WORLD"]
}

# Map for object
locals {
  for_map_object_input = {
    key1 = {
      name = "hello"
    }
    key2 = {
      name = "world"
    }
  }
  for_map_object_result = { for key, value in local.for_map_object_input : key => value.name }
  # Result: map_object_result = { key1 = "hello", key2 = "world" }
}

# List for object
locals {
  for_list_object_input = [
    {
      name = "hello"
    },
    {
      name = "world"
    }
  ]
  for_list_object_result = [for obj in local.for_list_object_input : obj.name]
  # Result: for_list_object_result = ["hello", "world"]
  for_list_object_splat_result = local.for_list_object_input.*.name
  # Result: for_list_object_splat_result = ["hello", "world"]
}

output "for" {
  value = {
    map               = local.for_map_result
    list              = local.for_list_result
    map_object        = local.for_map_object_result
    list_object       = local.for_list_object_result
    list_object_splat = local.for_list_object_splat_result
  }
}
