module "amethyst--synthetic" {
  source           = "./modules/synthetic"
  providers        = { newrelic = newrelic.amethyst }
  var--alias       = var.account.amethyst.alias
  var--runbook_url = "https://obfuscated.com"
  var--channel_ids = [
    module.amethyst--channel.out--channel_id.email,
    module.amethyst--channel.out--channel_id.pagerduty,
  ]
  var--endpoints = {
    "google.com"   = var.location.amer
    "youtube.com"  = var.location.emea
    "facebook.com" = var.location.apac
  }
}

module "burgundy--synthetic" {
  source           = "./modules/synthetic"
  providers        = { newrelic = newrelic.burgundy }
  var--alias       = var.account.burgundy.alias
  var--runbook_url = "https://obfuscated.com"
  var--channel_ids = [
    module.burgundy--channel.out--channel_id.email,
    module.burgundy--channel.out--channel_id.pagerduty,
  ]
  var--endpoints = {
    "twitter.com"   = var.location.amer
    "instagram.com" = var.location.emea
    "yahoo.com"     = var.location.apac
  }
}

module "cerulean--synthetic" {
  source           = "./modules/synthetic"
  providers        = { newrelic = newrelic.cerulean }
  var--alias       = var.account.cerulean.alias
  var--runbook_url = "https://obfuscated.com"
  var--channel_ids = [
    module.cerulean--channel.out--channel_id.email,
    module.cerulean--channel.out--channel_id.pagerduty,
  ]
  var--endpoints = {
    "whatsapp.com" = var.location.amer
    "amazon.com"   = var.location.emea
    "netflix.com"  = var.location.apac
  }
}

module "dartmouth--synthetic" {
  source           = "./modules/synthetic"
  providers        = { newrelic = newrelic.dartmouth }
  var--alias       = var.account.dartmouth.alias
  var--runbook_url = "https://obfuscated.com"
  var--channel_ids = [
    module.dartmouth--channel.out--channel_id.email,
    module.dartmouth--channel.out--channel_id.pagerduty,
  ]
  var--endpoints = {
    "office.com"   = var.location.amer
    "reddit.com"   = var.location.emea
    "linkedin.com" = var.location.apac
  }
}
