resource "newrelic_alert_channel" "channel__email" {
  name = "Email : OBFUSCATED"
  type = "email"
  config {
    recipients = "OBFUSCATED"
  }
}

resource "newrelic_alert_channel" "channel__pd" {
  name = "PD : OBFUSCATED"
  type = "pagerduty"
  config {
    service_key = "OBFUSCATED"
  }
}

output "out__channel_ids" {
  value = [
    newrelic_alert_channel.channel__email.id,
    newrelic_alert_channel.channel__pd.id,
  ]
}
