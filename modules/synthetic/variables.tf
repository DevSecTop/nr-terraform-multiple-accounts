variable "var--alias" {
  description = "Account alias"
  type        = string
}

variable "var--runbook_url" {
  description = "Runbook URL"
  type        = string
}

variable "var--channel_ids" {
  description = "Channel IDs"
  type        = list(number)
}

variable "var--endpoints" {
  description = "Endpoints"
  type        = map(any)
}
