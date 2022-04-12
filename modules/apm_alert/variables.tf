locals {
  condition = {
    latency_app = {
      name      = "app exceeded latency threshold"
      query     = "${local.nrql.latency} FACET appName"
      type      = "static"
      threshold = 4
      duration  = 6
    }
    latency_host = {
      name      = "host exceeded latency threshold"
      query     = "${local.nrql.latency} FACET host"
      type      = "static"
      threshold = 6
      duration  = 8
    }

    error_app = {
      name      = "app exceeded error threshold"
      query     = "${local.nrql.error} FACET appName"
      type      = "static"
      threshold = 2
      duration  = 6
    }
    error_host = {
      name      = "host exceeded error threshold"
      query     = "${local.nrql.error} FACET host"
      type      = "static"
      threshold = 4
      duration  = 8
    }
  }

  nrql = {
    latency = "FROM Transaction SELECT average(duration) AS 'latency (sec)'"
    error   = "FROM Transaction SELECT percentage(count(*), WHERE error IS true) AS 'error (%)'"
  }
}

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
