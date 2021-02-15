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

- [Terraform](https://www.terraform.io/downloads.html) v0.14.6
- [New Relic Provider](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs) v2.18.0

## Usage

1. Once cloned, goto `./environments/` and run `terraform init` to initialize Terraform configuration files.
1. Configure:
   1. Notification channel details.<br>
      Found within [`./modules/channels/main.tf`](modules/channels/main.tf).
   1. Provider details for each account, such as: `account_id` and `api_key`.<br>
      Found within [`./environments/alpha.tf`](environments/alpha.tf) and [`./environments/bravo-x.tf`](environments/bravo-x.tf).
1. When ready, run `terraform apply` to preview changes before applying.

Observe that notifications channels, alert policies and conditions are generated and linked together for each account. Additionally, `bravo-x` account features a second alert policy with a different set of conditions, while reusing the same notification channels.

<details><summary>View tabulated list of alert conditions…</summary>

| environment | signal          | type     | threshold | occurrences   | nrql                                                                                                                                                          |
| ----------- | --------------- | -------- | --------: | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| alpha       | cpu utilisation | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName NOT LIKE 'P%X %'`                                               |
| alpha       | cpu utilisation | static   |        50 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName NOT LIKE 'P%X %'`                                               |
| alpha       | error rate      | baseline |         3 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName NOT LIKE 'P%X %'` |
| alpha       | error rate      | static   |         1 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName NOT LIKE 'P%X %'` |
| alpha       | memory usage    | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.memory.physical) / 1000 FACET appName WHERE appName NOT LIKE 'P%X %'`                                                 |
| alpha       | response time   | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                   |
| alpha       | response time   | static   |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                   |
| alpha       | throughput      | baseline |         3 | all           | `FROM Metric SELECT rate(count(apm.service.transaction.duration),1 minute) FACET appName WHERE appName NOT LIKE 'P%X %'`                                      |
| alpha       | throughput      | static   |    999999 | at_least_once | `FROM Metric SELECT count(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                     |
| bravo       | cpu utilisation | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName NOT LIKE 'P%X %'`                                               |
| bravo       | cpu utilisation | static   |        50 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName NOT LIKE 'P%X %'`                                               |
| bravo       | error rate      | baseline |         3 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName NOT LIKE 'P%X %'` |
| bravo       | error rate      | static   |         1 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName NOT LIKE 'P%X %'` |
| bravo       | memory usage    | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.memory.physical) / 1000 FACET appName WHERE appName NOT LIKE 'P%X %'`                                                 |
| bravo       | response time   | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                   |
| bravo       | response time   | static   |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                   |
| bravo       | throughput      | baseline |         3 | all           | `FROM Metric SELECT rate(count(apm.service.transaction.duration),1 minute) FACET appName WHERE appName NOT LIKE 'P%X %'`                                      |
| bravo       | throughput      | static   |    999999 | at_least_once | `FROM Metric SELECT count(apm.service.transaction.duration) FACET appName WHERE appName NOT LIKE 'P%X %'`                                                     |
| bravox      | cpu utilisation | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName LIKE 'P%X %'`                                                   |
| bravox      | cpu utilisation | static   |        50 | all           | `FROM Metric SELECT average(apm.service.cpu.usertime.utilization) FACET appName WHERE appName LIKE 'P%X %'`                                                   |
| bravox      | error rate      | baseline |         3 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName LIKE 'P%X %'`     |
| bravox      | error rate      | static   |         1 | all           | `FROM Metric SELECT count(apm.service.transaction.error.count) / count(apm.service.transaction.duration) \* 100 FACET appName WHERE appName LIKE 'P%X %'`     |
| bravox      | memory usage    | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.memory.physical) / 1000 FACET appName WHERE appName LIKE 'P%X %'`                                                     |
| bravox      | response time   | baseline |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName LIKE 'P%X %'`                                                       |
| bravox      | response time   | static   |         3 | all           | `FROM Metric SELECT average(apm.service.transaction.duration) FACET appName WHERE appName LIKE 'P%X %'`                                                       |
| bravox      | throughput      | baseline |         3 | all           | `FROM Metric SELECT rate(count(apm.service.transaction.duration),1 minute) FACET appName WHERE appName LIKE 'P%X %'`                                          |
| bravox      | throughput      | static   |    999999 | at_least_once | `FROM Metric SELECT count(apm.service.transaction.duration) FACET appName WHERE appName LIKE 'P%X %'`                                                         |

</details>

## Installation

### Modules

- Each module is located in its own subdirectory to:
  - Encourage reusability: keeping code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself).
  - Prevent conflict of duplicate entity names.
- They're paired with a generic [`versions.tf`](modules/channels/versions.tf) which inherits specific version details from [`./environments/versions.tf`](environments/versions.tf): remaining flexible for upgrades.

| Module                               | Description                                         | Input                                                               | Output                                |
| ------------------------------------ | --------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------- |
| [channels](modules/channels/main.tf) | Alert notification channels.                        | None.                                                               | List of `newrelic_alert_channel` IDs. |
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

[GNU General Public License v3.0](LICENSE)

## Credits

Neither myself nor this project are associated with New Relic™.

All works herein are my own and shared of my own volition.

Copyleft @ All wrongs reserved.
