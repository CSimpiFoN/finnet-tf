module "static_sites" {
  source = "./modules/static-site"
  static_sites = {
    auth = {
      site_number = 1
    },
    info = {
      site_number = 2
    },
    customers = {
      site_number = 3
    }
  }
  environment = var.environment
}