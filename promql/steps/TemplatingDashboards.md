**Objective:** understand dashboard templating

You just saw that you can use operators to filter results. Now, imagine that you want to have a separate graph for each value
that a label can have. That would be quite quite a tedious task to perform manually.

Luckilly, Grafana offers the option to define dashboard variables which in combination with Prometheus label operators will make
this a trivial task. Grafana calls this option **Templating**. You don’t need to create a graph for every value in your label since 
you can use the **repeat** option in combination with a variable. You can find the variables section in the dashboard settings (little
gear on the top right corner), while the repeat option is in the General tab in our graph.

Grafana has a special function `label_values(<label>)` or `label_values(<metric>,<label>)` that you can use to assign label values
to your dashboard variable.

If you want to refer to the value of the variable in your query, you can add them by using `$variable name` or `[[variable name]]`. 
**Multi-value** or variables with an **All** option are converted to the appropriate regular expressions.

## Assignment
1. Create a Variable for the label `country`. __Tip: variables have a Datasource too__
1. Change the dashboard to show a graph for each country. Each graph should display only the line that corresponds to its country.
1. Add the variable to the title of the graph too