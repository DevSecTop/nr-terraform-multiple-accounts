output "out--channel_id" {
  description = "Channel IDs"
  value = {
    email     = newrelic_alert_channel.email.id,
    pagerduty = newrelic_alert_channel.pagerduty.id,
  }
}
