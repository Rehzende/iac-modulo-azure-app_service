data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_linux_web_app" "app" {
  name                = var.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on = true

    application_stack {
      docker_image     = var.docker_image
      docker_image_tag = var.docker_image_tag
    }
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_server_url
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_server_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_server_password
  }
}
