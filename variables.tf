##########################################################################
# 0. Global Configuration
##########################################################################
variable "application" {
  description = "Name of the application for which the resources are created (agw,corenet etc.)"
  type        = string
}

variable "technical_zone" {
  description = "Enter a 2-digits technical zone which will be used by resources (in,ex,cm,sh)"
  type        = string

  validation {
    condition = (
      length(var.technical_zone) > 0 && length(var.technical_zone) <= 2
    )
    error_message = "The technical zone must be a 2-digits string."
  }
}
variable "environment" {
  description = "Enter the 3-digits environment which will be used by resources (hpr,sbx,prd,hyb)"
  type        = string

  validation {
    condition = (
      length(var.environment) > 0 && length(var.environment) <= 3
    )
    error_message = "The environment must be a 3-digits string."
  }
}

variable "location" {
  description = "Enter the region for which to create the resources."
}

variable "tags" {
  description = "Tags to apply to your resources"
  type        = map(string)
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

##########################################################################
# 1. Virtual Network Configuration
##########################################################################

variable "subnet_id" {
  description = "A subnet ID needed to create the virtual machine"
}
##########################################################################
# 2. Instances
##########################################################################

variable "platform" {
  description = "Choose the OS platform"
  type        = string
  validation {
    condition = (
      var.platform == "windows" || var.platform == "linux"
    )
    error_message = "The platform is either `windows` or `linux`."
  }
}
variable "vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create."
}

variable "admin_username" {
  description = "Username for Virtual Machine administrator account"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Password for Virtual Machine administrator account. A random password will be generated if not used."
  type        = string
  default     = null
}

variable "vm_image" {
  type        = map(string)
  description = "Virtual machine source image information"
}

variable "boot_diagnostics_storage_account_uri" {
  description = "Storage Account URI to create boot diagnostics logs"
  type        = string
  default     = null
}

variable "key_vault_id" {
  description = "Provide a key vault ID to store the machine password"
  type        = string
}
