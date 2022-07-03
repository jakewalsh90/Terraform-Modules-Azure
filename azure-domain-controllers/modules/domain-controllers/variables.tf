variable "pri-location" {
  description = "Location for Primary Objects that are only required in a single region"
  default     = "uksouth"
}
variable "regions" {
  description = "Locations and CIDR Ranges"
  type        = map(any)
  default = {
    location1 = {
      location = "uksouth"
      vnetcidr = ["10.10.0.0/16"]
      snetcidr = ["10.10.1.0/24"]
    }
  }
}