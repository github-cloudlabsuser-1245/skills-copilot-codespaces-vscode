provider "azurerm" {
  features {}
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Location for the storage account"
  type        = string
  default     = "eastus"
}

variable "sku_name" {
  description = "The SKU of the storage account"
  type        = string
  default     = "Standard_LRS"
  validation {
    condition     = contains(["Standard_LRS", "Standard_GRS", "Standard_ZRS", "Premium_LRS"], var.sku_name)
    error_message = "The SKU must be one of Standard_LRS, Standard_GRS, Standard_ZRS, Premium_LRS."
  }
}

variable "access_tier" {
  description = "The access tier used for billing"
  type        = string
  default     = "Hot"
  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "The access tier must be either Hot or Cool."
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.access_tier
  account_replication_type = var.sku_name

  lifecycle {
    prevent_destroy = true
  }
}