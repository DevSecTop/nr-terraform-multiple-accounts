locals {
  latency = "FROM Transaction SELECT average(duration) AS 'latency (sec)'"
  error   = "FROM Transaction SELECT percentage(count(*), WHERE error IS true) AS 'error (%)'"
}

resource "newrelic_one_dashboard" "dashboard" {
  name        = "${var.var--alias} Dashboard"
  permissions = "public_read_write"
  page {
    name = "${var.var--alias} Dashboard"
    widget_markdown {
      title  = ""
      row    = 1
      column = 1
      width  = 4
      height = 6
      text   = <<-EOT
               # Entity level

               Breakout activity across the [Golden Signals](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/#xref_monitoring_golden-signals) for SRE.

               &nbsp;
               ## Golden signals

               * **Latency:** Response time taken to service a request: seconds (sec).
               * **Error:** Failure rate of requests with error codes: percentage (%).

               &nbsp;
               ## Time

               Along with the time picker in the top-right corner, you can click-hold-and-drag across any chart to zoom into that period of time.
               EOT
    }
    widget_line {
      title  = "⏱️ Latency by app (sec)"
      row    = 1
      column = 5
      width  = 4
      height = 3
      nrql_query {
        query = "${local.latency} FACET appName SINCE 1 hour AGO LIMIT MAX TIMESERIES AUTO"
      }
    }
    widget_line {
      title  = "⏱️ Latency by host (sec)"
      row    = 1
      column = 9
      width  = 4
      height = 3
      nrql_query {
        query = "${local.latency} FACET host SINCE 1 hour AGO LIMIT MAX TIMESERIES AUTO"
      }
    }
    widget_line {
      title  = "🚫 Error by app (%)"
      row    = 4
      column = 5
      width  = 4
      height = 3
      nrql_query {
        query = "${local.error} FACET appName SINCE 1 hour AGO LIMIT MAX TIMESERIES AUTO"
      }
    }
    widget_line {
      title  = "🚫 Error by host (%)"
      row    = 4
      column = 9
      width  = 4
      height = 3
      nrql_query {
        query = "${local.error} FACET host SINCE 1 hour AGO LIMIT MAX TIMESERIES AUTO"
      }
    }
    widget_markdown {
      title  = ""
      row    = 7
      column = 1
      width  = 12
      height = 1
      text   = ""
    }
    widget_markdown {
      title  = ""
      row    = 8
      column = 1
      width  = 4
      height = 4
      text   = <<-EOT
               # Filter level

               Slice activity in any way that's required. For example:

               * **App:** Activity across any given app.
               * **Host:** Activity across any given host.

               &nbsp;
               **TIP:** Combine filters to surface relational activity.
               EOT
    }
    widget_bar {
      title  = "🔻 Filter by app"
      row    = 8
      column = 5
      width  = 4
      height = 4
      nrql_query {
        query = "${local.latency} FACET appName SINCE 1 hour AGO LIMIT MAX"
      }
      filter_current_dashboard = true
    }
    widget_bar {
      title  = "🔻 Filter by host"
      row    = 8
      column = 9
      width  = 4
      height = 4
      nrql_query {
        query = "${local.latency} FACET host SINCE 1 hour AGO LIMIT MAX"
      }
      filter_current_dashboard = true
    }
  }
}
