packer {
  required_plugins {
    azure = {
      version = ">= 1.3.1"
      source  = "github.com/hashicorp/azure"
    }
  }
}