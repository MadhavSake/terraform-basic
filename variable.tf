variable "project" {
    type = string
    description = "The project ID to manage the resources"
    default = "add-your-project-id"
}

variable "region" {
    type = string
    description = "The region of the resources"
    default = "asia-south1"
}

variable "zone" {
    type = string
    description = "The zone of the resources"
    default = "asia-south1-a"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "test-vpc"
}

variable "nat_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "test-nat"
}

variable "firewall_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "test-firewall"
}



