module "amethyst--channel" {
  source    = "./modules/channel"
  providers = { newrelic = newrelic.amethyst }
}

module "burgundy--channel" {
  source    = "./modules/channel"
  providers = { newrelic = newrelic.burgundy }
}

module "cerulean--channel" {
  source    = "./modules/channel"
  providers = { newrelic = newrelic.cerulean }
}

module "dartmouth--channel" {
  source    = "./modules/channel"
  providers = { newrelic = newrelic.dartmouth }
}
