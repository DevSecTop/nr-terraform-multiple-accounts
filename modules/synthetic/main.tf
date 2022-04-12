resource "newrelic_alert_policy" "policy" {
  name                = "${var.var--alias} Synthetic Alerts"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

resource "newrelic_alert_policy_channel" "policy_channel" {
  policy_id   = newrelic_alert_policy.policy.id
  channel_ids = var.var--channel_ids
}

resource "newrelic_synthetics_monitor" "monitor" {
  for_each            = var.var--endpoints
  name                = "${var.var--alias} ${each.key}"
  type                = "SIMPLE"
  status              = "ENABLED"
  bypass_head_request = true
  verify_ssl          = false
  frequency           = 5
  uri                 = "https://${each.key}"
  locations           = each.value
}

resource "newrelic_synthetics_multilocation_alert_condition" "condition" {
  entities                     = [for v in newrelic_synthetics_monitor.monitor : v.id]
  policy_id                    = newrelic_alert_policy.policy.id
  name                         = "violated synthetic check"
  runbook_url                  = var.var--runbook_url
  violation_time_limit_seconds = 60 * 60 * 24
  critical { threshold = 3 }
  warning { threshold = 1 }
}
