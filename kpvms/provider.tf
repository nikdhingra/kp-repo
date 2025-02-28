terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
}

provider "azurerm" {
  #resource_provider_registrations = "none"
  subscription_id = "9bd2fe7b-8da1-4dad-ac7c-7766fe130a05"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }
}