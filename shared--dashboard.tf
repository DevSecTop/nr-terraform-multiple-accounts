module "amethyst--dashboard" {
  source     = "./modules/dashboard"
  providers  = { newrelic = newrelic.amethyst }
  var--alias = var.account.amethyst.alias
}

module "burgundy--dashboard" {
  source     = "./modules/dashboard"
  providers  = { newrelic = newrelic.burgundy }
  var--alias = upper(var.account.burgundy.alias)
}

module "cerulean--dashboard" {
  source     = "./modules/dashboard"
  providers  = { newrelic = newrelic.cerulean }
  var--alias = upper(var.account.cerulean.alias)
}

module "dartmouth--dashboard" {
  source     = "./modules/dashboard"
  providers  = { newrelic = newrelic.dartmouth }
  var--alias = upper(var.account.dartmouth.alias)
}
