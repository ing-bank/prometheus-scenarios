# Templating Dashboards
**Objective:** understand dashboard templating

You just saw that you can use operators to filter results. Now, imagine that you want to have a separate panel for each value
that a label can have. That would be quite a tedious task to perform manually.
Luckily, Grafana offers the option to define dashboard variables which in combination with Prometheus label operators make
this a trivial task. Grafana calls this option **Templating**. You can also use the **repeat** option in combination with a 
variable and Grafana will figure out that it has to make a panel for every value. 
You can find the variables section in the dashboard settings (little gear on the top right corner), while the repeat option 
is in the General tab in our graph.

Grafana has a special function `label_values(<label>)` or `label_values(<metric>,<label>)` that you can use to assign label values
to your dashboard variable.

If you want to refer to the value of the variable in your query, you can add them by using `$variable name` or `[[variable name]]`. 
**Multi-value** or variables with an **All** option are converted to the appropriate regular expressions.

Variables also have a *refresh* setting that tells Grafana how often it has to fetch its values.
This is often overlooked and causes some headaches. It is also possible to hide the label (when the values are self explaining)
or even the entire variable (especially when used to show panels for all values of the variable).

## Assignment
1. Create a Variable for the label `country`. _Tip: variables have a Datasource too_  
    a. make sure you select the `all` and `multi value` options too
1. Change the dashboard to show a panel for each country. 
1. Each graph should display only the line that corresponds to its country. _Tip: this option is called repeat_
1. Adjust the title of each panel to show which country this is for

_N.B. Grafana has a non-intuitive behavior with regards to the variables.
When you make changes to a graph using the repeat option, only the first one is editable.
Ant change you make will not be applied immediately.
You need to select one value and then select them all again to refresh all the graphs!_

<details>
  <summary>Show solution</summary>

  **Solution**.

  1. You can create variables by clicking the settings button (gear icon) in your dashboard and then select variables
  from the menu. Create a variable called `country` with query: `label_values(country)`.  Enable the `All` option.
  If you have done everything right, you see the variable values at the bottom of the page.
  1. You should have changed the query in the the panel: `logged_on_customers{country=~"^$country$"}`. Note that the variable should be matched using a regular expression. When either `All` or `Multi-value` is enabled, the variable values will be encoded as a regular expression.
  1. In the panel options of your panel you can find the repeat option. The dropdown value should be set to `country`  
  1. In the same section you can change the title of the panel this should be set to: `Logged on Customers $country`.  
</details>


---
## [< previous](03%20-%20Label%20Operators.md) | [next >](..)
