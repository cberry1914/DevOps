terraform {
  required_providers { #tells TF which plugins it needs to talk to your cloud of choice. Right now it's Azure because of azurerm
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
#empty features block is required syntax even with nothing inside it. TF automatically uses existing az login session. 
#Real production setups usually use a dedicated more restricted service identity instead of a personal login
provider "azurerm" { #configures the actual connection to Azure
  features {}   
}
#the actual thing being created "azurerm_resource_group" is the resource type and is defined by the azurerm provider. 
#"practice" is a local name alias. 
#"name" and "location" are the actual resource groups real name and region. This shows up when running azure command 'az group list'
resource "azurerm_resource_group" "practice" {  
  name     = "terraform-practice-rg"
  location = "centralus"
  tags = {
    Environment = "DEV"
    Department = "EHS"
    ManagedBy = "Terraform"
  }
}