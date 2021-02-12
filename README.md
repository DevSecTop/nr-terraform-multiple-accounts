# New Relic Terraform for Multiple Accounts

> Prototype which adopts a flat, modular approach to generating resources at scale for multiple accounts using New Relic's Terraform provider.

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Installation](#installation)
  - [Modules](#modules)
  - [Environments](#environments)
- [Support](#support)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v0.14.0+
- [New Relic Provider](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs) v2.18.0+

## Usage

1. Once cloned, goto `./environments/` and run `terraform init` to initialize Terraform configuration files.
1. Configure:
   1. Notification channel details.<br>
      Found within [`./modules/channels/main.tf`](modules/channels/main.tf).
   1. Provider details for each account, such as: `account_id` and `api_key`.<br>
      Found within [`./environments/alpha.tf`](environments/alpha.tf) and [`./environments/bravo-x.tf`](environments/bravo-x.tf).
1. When ready, run `terraform apply` to preview changes before applying.

Observe that notifications channels, alert policies and conditions are generated and linked together for each account. Additionally, `bravo-x` account features a second alert policy with a different set of conditions.

## Installation

### Modules

- Each is module is located in its own subdirectory to:
  - Encourage reusability: keeping code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself).
  - Prevent conflict of duplicate entity names.
- They're paired with a generic `versions.tf` which inherits specific version details from [`./environments/versions.tf`](environments/versions.tf): remaining flexible for upgrades.

| Module                                 | Description                                         | Input                                                                       | Output                                |
| -------------------------------------- | --------------------------------------------------- | --------------------------------------------------------------------------- | ------------------------------------- |
| [channels](modules/channels/main.tf) | Alert notification channels.                        | None.                                                                       | List of `newrelic_alert_channel` IDs. |
| [alerts](modules/alerts/main.tf)     | Alert policy with associated NRQL alert conditions. | Name of alert policy; list of alert channel IDs; selection of apps. | None.                                 |

### Environments

- Due to the flat directory structure, the `terraform apply` command addresses available accounts altogether.
  - This removes the need for external wrappers, such as [Terragrunt](https://terragrunt.gruntwork.io/).
  - At the cost of needing each module reference to have a unique name.
- Each account requires an alias in order to pass its associated `account_id` into referenced modules via `providers`.

## Support

- For general queries about the developer toolkit, [New Relic Explorers Hub](https://discuss.newrelic.com/c/build-on-new-relic/developer-toolkit/) is a good starting point.
- For specific queries about New Relic's Terraform provider, [newrelic/terraform-provider-newrelic](https://github.com/newrelic/terraform-provider-newrelic/issues) is your best bet.

## Roadmap

1. Override NRQL alert conditions on a per-account basis.
1. Generate NRQL alert conditions by looping through variable map arrays.
1. Create a dashboard module to display [Golden Signals](https://sre.google/sre-book/monitoring-distributed-systems/#xref_monitoring_golden-signals).

## Contributing

Pull requests are welcome and appreciated. For major contributions, please open an issue to discuss what you would like to change.

## License

[gpl-3.0](LICENSE) GNU General Public License v3.0

## Credits

Neither myself nor this project are associated with New Relic™.

All works herein are my own, shared of my own volition.

Copyleft @ All wrongs reserved.
