# New Relic Terraform for Multiple Accounts

> Prototype which adopts a flat, modular approach to generating resources at scale for multiple accounts using New Relic's Terraform provider without any dependencies.

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Configuration](#configuration)
- [Support](#support)
- [Issues](#issues)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) ~> 1.0
- [New Relic Provider](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs) ~> 2.0

## Usage

1. Clone the repository.
1. Access [terraform.tfvars.json](terraform.tfvars.json).
1. Replace `account_id`, `api_key`, and (optionally) `alias` with your accounts' data.
1. Initialise Terraform with latest provider: `terraform init -upgrade`.
1. Apply configuration with placeholder data: `terraform apply -auto-approve -compact-warnings`.

## Configuration

- For a flat structure, shared configurations are prefixed `shared--` at the root of the directory.
  - This removes the need for external wrappers, such as [Terragrunt](https://terragrunt.gruntwork.io/).
  - Each account requires an alias in order to pass its associated `account_id` into referenced modules via `providers`.
- Each module is located in its own subdirectory to:
  - Encourage reusability: keeping code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself).
  - Prevent conflict of duplicate entity names.
- Modules are paired with a generic [`versions.tf`](modules/channel/versions.tf) which inherits version details from the root to remain flexible for upgrades.

| Module                                 | Description                                                       | Input                                                   | Output         |
| -------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------- | -------------- |
| [apm_alert](modules/apm_alert/main.tf) | APM alert policies and associated NRQL conditions.                | Account alias, runbook URL and channel IDs.             | None.          |
| [channel](modules/channel/main.tf)     | Alert notification channels.                                      | None.                                                   | Channel IDs.   |
| [dashboard](modules/dashboard/main.tf) | Dashboard.                                                        | Account alias.                                          | Dashboard URL. |
| [synthetic](modules/synthetic/main.tf) | Synthetic monitors and associated multilocation alert conditions. | Account alias, runbook URL, channel IDs, and endpoints. | None.          |

## Support

- For general queries about the developer toolkit, [New Relic Explorers Hub](https://discuss.newrelic.com/c/build-on-new-relic/developer-toolkit/) is a good starting point.
- For specific queries about New Relic's Terraform provider, [newrelic/terraform-provider-newrelic](https://github.com/newrelic/terraform-provider-newrelic/issues) is your best bet.

## Issues

- Synthetic multilocation alert condition is changed on every run.
  - Workaround: Add `lifecycle { ignore_changes = [entities] }` to the resource to ignore changes.

## Contributing

Pull requests are welcome and appreciated. For major contributions, please open an issue to discuss what you would like to change.

## License

[GNU Affero General Public License v3.0](LICENSE)

## Credits

Neither myself nor this project are associated with New Relic™.

All works herein are my own and shared of my own volition.

Copyleft @ All wrongs reserved.
