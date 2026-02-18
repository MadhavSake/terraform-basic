variable "project" {
  type        = string
  description = "The project ID to manage the resources"
  default     = "your-gcp-project-name"
}

variable "region" {
  type        = string
  description = "The region of the resources"
  default     = "asia-south1"
}

variable "zone" {
  type        = string
  description = "The zone of the resources"
  default     = "asia-south1-a"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "test-vpc-gke"
}

variable "nat_name" {
  type        = string
  description = "Name of the NAT gateway"
  default     = "test-nat=gke"
}

variable "firewall_name" {
  type        = string
  description = "Name of the firewall rule"
  default     = "test-firewall-gke"
}

variable "gke_name" {
  type        = string
  description = "The project ID to manage the resources"
  default     = "test-gke-cluster"
}
