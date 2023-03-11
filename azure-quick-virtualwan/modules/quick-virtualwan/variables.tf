variable "virtualwan-name" {
  description = "Default name for the Virtual WAN"
  default     = "virtualwan1"
}
variable "regions" {
  description = "Regional variables"
  type        = map(any)
  default = {
    location1 = {
      location = "uksouth"
      hubcidr  = "10.10.0.0/21"
    }
  }
}