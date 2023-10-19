variable "vdc_org_name" {
  description = "The name of the organization to use."
  type        = string
  default     = null
}

variable "context_id" {
  description = "ID of NSX-T Manager, VDC or VDC Group. It accepts VDC, VDC Group or NSX-T Manager ID."
  type        = string
  default     = null
}

variable "name" {
  description = "A unique name for Port Profile."
  type        = string
}

variable "scope" {
  description = "Application Port Profile scope - PROVIDER, TENANT. Default: TENANT"
  type        = string
  default     = "TENANT"
}

variable "app_ports" {
  description = "At least one block of Application Port definition."
  type = list(object({
    protocol = string
    port     = set(string)
  }))
}
