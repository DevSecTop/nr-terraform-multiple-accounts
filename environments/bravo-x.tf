provider "newrelic" {
  alias      = "bravo"
  account_id = "OBFUSCATED"
  api_key    = "OBFUSCATED"
}

module "bravo__channels" {
  source    = "../modules/channels"
  providers = { newrelic = newrelic.bravo }
}

module "bravo__alerts" {
  source           = "../modules/alerts"
  providers        = { newrelic = newrelic.bravo }
  var__policy_name = "${upper("bravo")} app"
  var__channel_ids = module.bravo__channels.out__channel_ids
  var__nrql_filter = "appName NOT LIKE 'P%X %'"
}

module "bravox__alerts" {
  source           = "../modules/alerts"
  providers        = { newrelic = newrelic.bravo }
  var__policy_name = "${upper("bravo")}X app"
  var__channel_ids = module.bravo__channels.out__channel_ids
  var__nrql_filter = "appName LIKE 'P%X %'"
}
