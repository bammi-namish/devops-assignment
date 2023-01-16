variable "project_id" {
  description = "project id"
  type        = string
  default     = "dataloop-candidate-environment"
}

variable "region" {
  description = "region"
  type        = string
  default     = "us-central1"
}

variable "vpc_cidr" {
  description = "IP Address CIDR for vpc"
  type        = string
  default     = "10.10.0.0/24"
}

variable "gke_num_nodes" {
  type        = number
  description = "number of gke nodes"
  default     = 2
}

variable "gke_instance_type" {
  type        = string
  description = "gke instance type"
  default     = "e2-small"
}

