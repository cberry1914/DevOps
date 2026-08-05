terraform {
  required_providers { #tells TF which plugins it needs to talk to your cloud of choice. Right now it's Azure because of azurerm
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" { #configures the actual connection to Azure
  features {}   #empty features block is required syntax even with nothing inside it. TF automatically uses existing az login session. Real proeuction setups usually use a dedicated more restricted service identity instead of a personal login
}

resource "azurerm_resource_group" "practice" {  #the actual thing being created "azurerm_resource_group" is the resource type-is defined by the azurerm provider. "practice" is a local name alias. "name" and "location" are the actual resource groups real name and region. This shows up when running 'az group list'
  name     = "terraform-practice-rg"
  location = "centralus"
  tags = {
    Environment = "DEV"
    Department = "EHS"
    ManagedBy = "Terraform"
  }
}