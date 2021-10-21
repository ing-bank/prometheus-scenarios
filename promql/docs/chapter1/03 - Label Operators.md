# PromQL Label Operators
**Objective:** understand different label selection operators.

Prometheus has a few operators to allow you to influence the selection on your labels:
* '=' Selects labels that are exactly equal to the provided string
* '!=' Selects labels that are not equal to the provided string
* '=~' Selects labels that match the provided regex 
* '!~' Selects labels that do not match the provided regex

The label operators can only be used inside the curly braces in this way: `metric_name{ label operator "value" }` 
(The quotes are required). 

**Example:** `up{ job="mondemoapi" }` selects all the data points in the `up` metrics with label 
`job` and value `mondemoapi`.

**N.B.** When you use the regex operator, it's a good practice to enclose the expression between the anchors `^` and `$`.
For example: `up{ job=~"^.*demo.*$" }`. This will guarantee that your regex is not handled in different ways 
by different interpreters.

## Assignment


---
## [< previous](02%20-%20Panel%20Info.md) | [next >](04%20-%20Templating%20Dashboards.md)
