locals {
  tags = {
    "Env"          = "${terraform.workspace}",
    "Subscription" = "Development"
  }
}