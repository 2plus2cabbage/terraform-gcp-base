# Defines local variables for naming conventions in GCP
locals {
  vpc_name                      = "vpc-${var.environment_name}-${var.location}-"           # Prefix for VPC name
  subnet_name_prefix            = "snet-${var.environment_name}-${var.location}-"          # Prefix for subnet name
  windows_name_prefix           = "vm-${var.environment_name}-${var.location}-windows-"    # Prefix for Windows VM name
  firewall_rule_prefix          = "fw-${var.environment_name}-${var.location}-"            # Prefix for firewall rules
}