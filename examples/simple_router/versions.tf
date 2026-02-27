terraform {
  required_version = ">= 1.5"
  required_providers {
    vkcs = {
      source  = "vk-cs/vkcs"
      version = ">= 0.8.0, < 1.0.0"
    }
  }
}
