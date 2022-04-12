provider "newrelic" {
  alias      = "amethyst"
  account_id = var.account.amethyst.account_id
  api_key    = var.account.amethyst.api_key
}

provider "newrelic" {
  alias      = "burgundy"
  account_id = var.account.burgundy.account_id
  api_key    = var.account.burgundy.api_key
}

provider "newrelic" {
  alias      = "cerulean"
  account_id = var.account.cerulean.account_id
  api_key    = var.account.cerulean.api_key
}

provider "newrelic" {
  alias      = "dartmouth"
  account_id = var.account.dartmouth.account_id
  api_key    = var.account.dartmouth.api_key
}
