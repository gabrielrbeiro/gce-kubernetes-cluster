variable "deploy_id" {
  type        = string
  default     = "k8s"
  description = "A unique identifier to be used in resource naming (useful for multiple deployments)"
}

variable "project_id" {
  type        = string
  default     = ""
  description = "Your project id (only if using CSI plugin)"
}

variable "workers" {
  type = list(object({
    name          = string
    machine_type  = string
    zone          = string
    subnetwork_id = string
    private_ip    = string
  }))
  description = "A list of workers for cluster creation"
}

variable "masters" {
  type = list(object({
    name          = string
    machine_type  = string
    zone          = string
    subnetwork_id = string
    private_ip    = string
  }))
  description = "A list of masters for cluster creation"
}

variable "ssh_remote_user" {
  type        = string
  default     = ""
  description = "A user to access via SSH"
}

variable "ssh_public_key" {
  type        = string
  default     = ""
  description = "A public key to SSH"
}

variable "ssh_private_key" {
  type        = string
  default     = ""
  description = "A private key to SSH"
}

variable "allow_ssh_from_anywhere" {
  type        = bool
  default     = true
  description = "Allow SSH connections from anywhere"
}

variable "allow_ssh_from_iap" {
  type        = bool
  default     = true
  description = "Allow SSH connections from IAP"
}

variable "network_id" {
  type        = string
  description = "Network ID (for firewall rules)"
}
