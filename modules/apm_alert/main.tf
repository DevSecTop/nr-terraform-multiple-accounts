resource "newrelic_alert_policy" "policy" {
  name                = "${var.var--alias} APM Alerts"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

resource "newrelic_alert_policy_channel" "policy_channel" {
  policy_id   = newrelic_alert_policy.policy.id
  channel_ids = var.var--channel_ids
}

resource "newrelic_nrql_alert_condition" "condition" {
  for_each                       = local.condition
  policy_id                      = newrelic_alert_policy.policy.id
  name                           = each.value.name
  type                           = each.value.type
  runbook_url                    = var.var--runbook_url
  expiration_duration            = 60 * 2
  violation_time_limit_seconds   = 60 * 60 * 24
  slide_by                       = 30
  aggregation_delay              = 60 * 2
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  fill_option                    = "static"
  fill_value                     = 0
  open_violation_on_expiration   = false
  close_violations_on_expiration = true
  enabled                        = true
  nrql {
    query = each.value.query
  }
  critical {
    threshold             = each.value.threshold
    threshold_duration    = each.value.duration * 60
    operator              = "above"
    threshold_occurrences = "all"
  }
  warning {
    threshold             = each.value.threshold
    threshold_duration    = floor(each.value.duration * 0.8) * 60
    operator              = "above"
    threshold_occurrences = "all"
  }
}
