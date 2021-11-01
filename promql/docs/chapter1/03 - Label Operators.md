# PromQL Label Operators
**Objective:** understand different label selection operators.

Prometheus has a few operators to allow you to influence the selection on your labels:
* '=' Selects labels that are exactly equal to the provided string
* '!=' Selects labels that are not equal to the provided string
* '=~' Selects labels that match the provided regex 
* '!~' Selects labels that do not match the provided regex

The label operators can only be used inside the curly braces in this way: `metric_name{ label operator "value" }` 
(The quotes are required). 

**Example:** `up{ job="mondemoapi" }` selects all the time series of the `up` metrics where label 
`job` has value `mondemoapi`.

**N.B.** When you use the regex operator, it's a good practice to enclose the expression between the anchors `^` and `$`.
For example: `up{ job=~"^demo[1-5]$" }`. This will guarantee that your regex is not handled in different ways 
by different interpreters. Prometheus specifies that these are implicit, but when using a remote-read on influxdb it will
match with non-anchored regular expressions. A regular expression given as `job=~"demo[1-5]"` will on Prometheus only match
time series with a label job and values demo1, demo2, demo3, demo4 and demo5. On InfluxDB it would match any time series
where the label job *contains* demo1, demo2, demo3, demo4 or demo5.

## Assignment
Adjust the dashboard so that it does not show the number of customers for the country 'nl'.

<details>
  <summary>Show solution</summary>

  **Solution**.

  1. Enter `logged_on_customers{ country!="nl" }` for the query.
</details>


---
## [< previous](02%20-%20Panel%20Info.md) | [next >](04%20-%20Templating%20Dashboards.md)
