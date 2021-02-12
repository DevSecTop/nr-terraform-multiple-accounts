locals {
  nrql__response_time   = "FROM Metric SELECT average(apm.service.transaction.duration)"
  nrql__throughput      = "FROM Metric SELECT rate(count(apm.service.transaction.duration), 1 minute)"
  nrql__error_rate      = "FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) * 100"
  nrql__cpu_utilisation = "FROM Metric SELECT average(apm.service.cpu.usertime.utilization)"
  nrql__memory_usage    = "FROM Metric SELECT average(apm.service.memory.physical) / 1000"
}

variable "var__policy_name" {
  type        = string
  description = "Name of alert policy"
}

variable "var__channel_ids" {
  type        = list
  description = "List of alert channel IDs"
}

variable "var__nrql_filter" {
  type        = string
  description = "Selection of apps"
}

resource "newrelic_alert_policy" "policy__alert" {
  name                = var.var__policy_name
  incident_preference = "PER_CONDITION_AND_TARGET"
  channel_ids         = var.var__channel_ids
}

resource "newrelic_nrql_alert_condition" "response_time__threshold" {
  name = "${var.var__policy_name} response time exceeded threshold"
  type = "static"
  value_function = "single_value"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__response_time} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "response_time__baseline" {
  name = "${var.var__policy_name} response time above baseline"
  type = "baseline"
  baseline_direction = "upper_only"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__response_time} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "throughput__baseline" {
  name = "${var.var__policy_name} throughput above baseline"
  type = "baseline"
  baseline_direction = "upper_only"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__throughput} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "throughput__signal_lost" {
  name = "${var.var__policy_name} throughput signal lost"
  type = "static"
  value_function = "single_value"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__throughput} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 999999
    threshold_occurrences = "AT_LEAST_ONCE"
    threshold_duration = 900
  }
  expiration_duration = 14400
  open_violation_on_expiration = true
  close_violations_on_expiration = false
}

resource "newrelic_nrql_alert_condition" "error_rate__threshold" {
  name = "${var.var__policy_name} error rate exceeded threshold"
  type = "static"
  value_function = "single_value"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__error_rate} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 1
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 1
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "error_rate__baseline" {
  name = "${var.var__policy_name} error rate above baseline"
  type = "baseline"
  baseline_direction = "upper_only"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__error_rate} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "cpu_utilisation__threshold" {
  name = "${var.var__policy_name} cpu utilisation exceeded threshold"
  type = "static"
  value_function = "single_value"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__cpu_utilisation} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 70
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 70
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "cpu_utilisation__baseline" {
  name = "${var.var__policy_name} cpu utilisation above baseline"
  type = "baseline"
  baseline_direction = "upper_only"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__cpu_utilisation} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}

resource "newrelic_nrql_alert_condition" "memory_usage__baseline" {
  name = "${var.var__policy_name} memory usage above baseline"
  type = "baseline"
  baseline_direction = "upper_only"
  violation_time_limit_seconds = 36000
  policy_id = newrelic_alert_policy.policy__alert.id
  nrql {
    query = "${local.nrql__memory_usage} FACET appName WHERE ${var.var__nrql_filter}"
    evaluation_offset = 3
  }
  critical {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 900
  }
  warning {
    operator = "above"
    threshold = 3
    threshold_occurrences = "ALL"
    threshold_duration = 720
  }
}
