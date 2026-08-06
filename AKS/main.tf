terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "aks-practice-rg"
  location = "centralus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-practice-cluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "akspractice"

#default_node_pool is the part that actually costs money and takes time to provision: 
#it's telling Azure "create 1 real VM (created Standard_B2s successfully for the Ansible VMs) to serve as a Kubernetes worker node." 
#This is the concrete thing to point to when explaining "AKS manages the control plane, you still pay for and manage the nodes" — 
#this block is that node management, expressed as one line of config.
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }
#AKS needs its own identity to manage other Azure resources on your behalf ex. creating load balancers when you make a LoadBalancer Service
#SystemAssigned tells Azure to automatically create and manage that identity for you
  identity {
    type = "SystemAssigned"
  }
}