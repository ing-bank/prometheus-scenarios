# Exploring Metrics
**Objective:** know how to look through your metrics to see what is available

You can observe the metrics with either Grafana or directly with Prometheus.

## Grafana

For [Grafana](localhost:3000) you can explore metrics by hitting the compass icon on the left bar.
If you start typing a metric name it will pop up a list of matching metrics.

## Assignment
1. Start typing `api`.
1. Select `api_response_status_count` from the list.
1. Run the query.
1. Observe how the lines in the Graph are steadily rising.
1. Observe how Grafana shows a message underneath the query: Metric api_response_status_count is a counter. Fix by adding rate()
1. Click on `Fix by adding rate()` and notice how this changes your query.

You can also select to see a Range, Instant or Both, depending on what is selected Run Query will either produce a Graph, a Table or both.

An alternative to typing the metric is clicking on the *Metric browser* this will show a panel listing all metrics and labels available. Hovering the
mouse cursor over a metric name will show the Help information of the metric that should inform you what the metric means.

You can hit the `Use query` button to use the query that you assembled.

## Prometheus

For [Prometheus](localhost:9090) you arrive at the page for exploring metrics by default. If you start typing a metric name it
will pop up a list of matching metrics.

## Assignment
1. Start typing `api`.
1. Select `api_response_status_count` from the list.
1. Run the query (press Execute)



---
## [< previous](04%20-%20Templating%20Dashboards.md) | [next >](..)
