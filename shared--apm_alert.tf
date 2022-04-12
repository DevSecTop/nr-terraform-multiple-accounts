module "amethyst--alerts" {
  source           = "./modules/apm_alert"
  providers        = { newrelic = newrelic.amethyst }
  var--alias       = var.account.amethyst.alias
  var--runbook_url = "https://obfuscated.com"
  var--channel_ids = [
    module.amethyst--channel.out--channel_id.email,
    module.amethyst--channel.out--channel_id.pagerduty,
  ]
}

module "burgundy--alerts" {
  source           = "./modules/apm_alert"
  providers        = { newrelic = newrelic.burgundy }
  var--runbook_url = "https://obfuscated.com"
  var--alias       = var.account.burgundy.alias
  var--channel_ids = [
    module.burgundy--channel.out--channel_id.email,
    module.burgundy--channel.out--channel_id.pagerduty,
  ]
}

module "cerulean--alerts" {
  source           = "./modules/apm_alert"
  providers        = { newrelic = newrelic.cerulean }
  var--runbook_url = "https://obfuscated.com"
  var--alias       = var.account.cerulean.alias
  var--channel_ids = [
    module.cerulean--channel.out--channel_id.email,
    module.cerulean--channel.out--channel_id.pagerduty,
  ]
}

module "dartmouth--alerts" {
  source           = "./modules/apm_alert"
  providers        = { newrelic = newrelic.dartmouth }
  var--runbook_url = "https://obfuscated.com"
  var--alias       = var.account.dartmouth.alias
  var--channel_ids = [
    module.dartmouth--channel.out--channel_id.email,
    module.dartmouth--channel.out--channel_id.pagerduty,
  ]
}
