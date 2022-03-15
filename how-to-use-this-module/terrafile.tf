provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "mentoria-rg"
  location = "Central US"
}

resource "azurerm_app_service_plan" "app" {
  name                = "asp-mentoria-iac"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

module "app_service" {
  source              = "../"
  name                = "mentoria-iac-bot"
  resource_group_name = "mentoria-iac"
  app_service_plan_id = azurerm_app_service_plan.app.id
  docker_image        = "httpd:latest"
}


