# Templating Dashboards
**Objective:** understand dashboard templating

You just saw that you can use operators to filter results. Now, imagine that you want to have a separate graph for each value
that a label can have. That would be quite a tedious task to perform manually.
Luckily, Grafana offers the option to define dashboard variables which in combination with Prometheus label operators make
this a trivial task. Grafana calls this option **Templating**. You can also use the **repeat** option in combination with a 
variable and Grafana will figure out that it has to make a graph for every value. 
You can find the variables section in the dashboard settings (little gear on the top right corner), while the repeat option 
is in the General tab in our graph.

Grafana has a special function `label_values(<label>)` or `label_values(<metric>,<label>)` that you can use to assign label values
to your dashboard variable.

If you want to refer to the value of the variable in your query, you can add them by using `$variable name` or `[[variable name]]`. 
**Multi-value** or variables with an **All** option are converted to the appropriate regular expressions.

Variables also have a *refresh* setting that tells Grafana how often it has to fetch its values.
This is often overlooked and causes some headaches.

## Assignment
1. Create a Variable for the label `country`. _Tip: variables have a Datasource too_
1. Change the dashboard to show a graph for each country. 
1. Each graph should display only the line that corresponds to its country.
1. Add the variable to the title of the graph too.

<details>
  <summary>Show solution</summary>

  **Solution**.  

  1. You can create variables by clicking the settings button (gear icon) in your dashboard and then select variables
  from the menu. You have should created a variable called `country` with query: `label_values(country)`.  
  If you have done everything right, you see the variable values at the end of the page.
  1. You should have changed the query in the the panel: `logged_on_customers{country=~"^$country$"}`  
  1. In the general tab of your panel you can find the repeat option. The dropdown value should be set to `country`  
  1. In the same tab, you should have set title of the dashboard to: `Logged on Customers $country`.  
</details>


---
## [< previous](03%20-%20Label%20Operators.md) | [next >](..)
