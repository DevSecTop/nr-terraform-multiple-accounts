terraform {
  required_version = "~> 0.14.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.18.0"
    }
  }
}
