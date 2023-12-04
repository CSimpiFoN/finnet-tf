locals {
  state_file = join("", ["./", var.environment,"terraform.tfstate"])
}