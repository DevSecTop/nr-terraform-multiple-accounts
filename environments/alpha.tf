provider "newrelic" {
  alias      = "alpha"
  account_id = "OBFUSCATED"
  api_key    = "OBFUSCATED"
}

module "alpha__channels" {
  source    = "../modules/channels"
  providers = { newrelic = newrelic.alpha }
}

module "alpha__alerts" {
  source           = "../modules/alerts"
  providers        = { newrelic = newrelic.alpha }
  var__policy_name = "${upper("alpha")} app"
  var__channel_ids = module.alpha__channels.out__channel_ids
  var__nrql_filter = "appName NOT LIKE 'P%X %'"
}
