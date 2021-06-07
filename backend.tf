terraform {
  backend "remote" {
    organization = "commonperil"

    workspaces {
      name = "infrastructure-vwan"
    }
  }
}