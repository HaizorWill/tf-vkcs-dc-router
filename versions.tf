terraform {
  required_version = ">= 0.14.0"
  required_providers {
    vkcs = {
      source  = "vk-cs/vkcs"
      version = "< 1.0.0"
    }
  }
}
