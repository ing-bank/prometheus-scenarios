# Prometheus Label Operators

**Objective:** understand different label selection operators.

Prometheus has a few operators to allow you to influence the selection on your labels:
* '=' Selects labels that are exactly equal to the provided string
* '!=' Selects labels that are not equal to the provided string
* '=~' Selects labels that match the provided regex 
* '!~' Selects labels that do not regex-match the provided string (or substring)

To the label operators can only be used inside the curly braces in this way: `metric_name{ label operator "value" }` 
(The quotes are required). E.g. `up{ job="mondemoapi" }` selects all the datapoints in the `up` metrics with label 
`job` and value `mondemoapi`.

## Assignment
Adjust the dashboard so that it does not show the number of customers for the country 'nl'.
