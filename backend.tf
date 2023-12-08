terraform {
  backend "http" {
    update_method = "POST"
    lock_method   = "POST"
    unlock_method = "DELETE"
  }
}
