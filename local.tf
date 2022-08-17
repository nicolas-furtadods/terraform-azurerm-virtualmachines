locals {
  ##########################################################################
  # 0. Global Configuration
  ##########################################################################
  naming               = replace(lower("${var.technical_zone}-${var.environment}-${var.application}"), " ", "")
  naming_noapplication = replace(lower("${var.technical_zone}-${var.environment}"), " ", "")

  ##########################################################################
  # 2. Instances
  ##########################################################################
  linux_startup = "./scripts/linux_startup.sh"

  windows_machine_name = "windows-${random_string.vm-name.result}"
  linux_machine_name   = "linux-${random_string.vm-name.result}"
}