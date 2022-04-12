output "out--dashboard_url" {
  description = "Dashboard URL"
  value       = newrelic_one_dashboard.dashboard.permalink
}
