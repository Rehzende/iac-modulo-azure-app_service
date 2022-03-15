data "azurerm_resource_group" "rg" {
  name = var.resource_group_name

}

resource "azurerm_app_service" "app" {
  name                = var.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = var.app_service_plan_id

  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"
  }
  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_server_url
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_server_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_server_password
  }

  lifecycle {
    ignore_changes = [
      #
      site_config,
    ]
  }
}



