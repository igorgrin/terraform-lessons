include "root" {
  path = find_in_parent_folders()
}

dependency "root" {
  config_path = path_relative_from_include()
}

inputs = {
  dns_zone         = dependency.root.outputs.dns_main
  dns_domain       = dependency.root.outputs.dns_domain
}
