resource "newrelic_alert_channel" "email" {
  name = "Email: Obfuscated"
  type = "email"
  config { recipients = "email@obfuscated.com" }
}

resource "newrelic_alert_channel" "pagerduty" {
  name = "PagerDuty: Obfuscated"
  type = "pagerduty"
  config { service_key = "obfuscated" }
}
