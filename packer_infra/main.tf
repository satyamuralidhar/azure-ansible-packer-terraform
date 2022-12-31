locals {
  tags = {
    "Env"          = "${terraform.workspace}",
    "Subscription" = "Development"
  }
}
locals {
  required_tags = {
    Account      = var.tags["Account"]
    Subscription = var.tags["Subscription"]
    Application  = var.tags["Application"]
  }
}

