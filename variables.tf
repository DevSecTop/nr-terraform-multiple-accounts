variable "account" {
  description = "Account data"
  type        = map(any)
  sensitive   = true
}

variable "location" {
  description = "Locations"
  type        = map(any)
}
