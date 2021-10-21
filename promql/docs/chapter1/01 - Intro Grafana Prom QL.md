# Intro to Grafana and PromQL
**Objective:** make your first graph.

Access [Grafana](http://localhost:3000/) and hover on the big plus sign
button in the left menu. Then click on **Dashboard**, and, on the new page, click on **Add Query**.

## Visualizations
You should now see an empty graph. Let's stop a moment here to look at all the settings that we have. 
On the top right corner, there are:
* a save button to save your dashboard
* a gear icon to change dashboard settings
* a clock icon; that's the timeframe that Grafana will use to collect data points from Prometheus
* a refresh dashboard button to enable automatic fetching of data at regular intervals

## Datasources
Below the graph, you can see the **Query** section. Every graph uses only one **Datasource**. Note that the default datasource
has a Prometheus icon. This has been pre-configured for you to send queries to the Prometheus server.  
There are lots of datasources types that Grafana can use, but this goes beyond the scope of this course.

## Metrics and Queries 
A basic Prometheus metric is formatted in Grafana using **PromQL** as: `metric_name{label1="value1",label2="value2"}`.
In other words this means: give me all the data points in the metric_name that match the label1="value1" and label2="value2".

By default, Prometheus creates a metric called **up** for every target that it scrapes. This metric has value 1 if the target
is up and 0 otherwise. Go ahead and type `up` in the metric input box and press enter. As soon as you type, Grafana shows 
an autocomplete menu that tries to guess what you want to type (if the autocomplete does not show the 'up' metric, just press 
`esc` on your keyboard to make it disappear).

## Assignment
Add the `up` metric and execute the query.

Note that the legend (just below the graph) shows the metric name with its label names and values. 
This metric has two labels that will be added by Prometheus to all the metrics that scrapes, this way you always know where
the metric comes from.



---
## [< previous](README.md) | [next >](02%20-%20Panel%20Info.md)
