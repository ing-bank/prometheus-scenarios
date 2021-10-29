# Grafana Panels
**Objective:** understand how to use the legend format to adjust the name of a time series and your graphs.

## Title
In the previous step, Grafana created a panel to let you input your query. The panel comes with a default title that gives no
information about what is shown in the panel. 

### Assignment 
1. Change the query to `logged_on_customers`
1. On the right of the screen under **Panel options` there is a `Title` option. Change the title to "Logged on customers". There is also a description field available to enter more information, when this is used a `i` will be shown in the top-left corner of your panel. Hovering over that `i` will show the description entered.

## Legend
You might have noticed that your legend for the **logged_on_customers** metric looks messy. That happened because Prometheus gives
back a value for every unique combination of the label values in the metric. If you want your visualization to look better,
you can adjust the way the time series is called using the option **Legend** under your query line. 
This field takes both static text or label values. To use label values, you need to put the label name between "{{" and "}}".
You can further customize the legend using the Legend options on the right side of the screen.

Grafana does not care about the uniqueness of names so take care to select appropriate labels or the result may end up highly 
confusing. 

### Assignment 
Adjust the dashboard to show only the country code in the legend

<details>
  <summary>Show solution</summary>

  **Solution**.  

  1. Enter `{{ country }}` for the legend.
</details>

## Resolution
The **Resolution** field is used to determine how many data points Grafana should receive from Prometheus. The default is 1/1 which 
means that Grafana tries to plot every data point to a pixel. With 1/2 Grafana will try to get a data point for each 2 pixels. 
By changing the resolution, you can smoothen the lines on the graph. 

## Graph styles
The looks of the graph can be further customized by adjusting the **Graph styles** on the right side panel. There is a wide range of options
available to customize the graph a full explanation is not in scope here.

## Axis
You can use the **Axis** section on the right side of the screen to alter the axis, for example to put a label on the axis describing what 
the values mean.

## Standard options
The **Standard options** section on the right side of the screen allows you to specify a unit for the values, the min/max values, number of decimals
and color scheme to use for the time-series in the graph. Especially the unit is very useful to make things explicit. For a graph showing the 'speed'
of something, it would be very useful to indicate that the values in the graph are km/h or m/s.

## Thresholds
The **Thresholds** section on the right side of the screen allows you to define threshold values and show these in the graph.

## Value mappings
The **Value mappings** section allows you to convert certain values to text. For a metric that returns the 'state' of an item, this could for
example indicate that a value 0 means OFF, value 1 means ON and value 2 means ERROR.

## Data links
The **Data links** section allows you to link to other dashboards (or generally to other resources) that give more information. You can for example
have a graph that shows power consumption per datacenter and have a data-link to another panel that would show a breakdown of the power consumption
for a particular datacenter.

## Conclusion
By adjusting the title, labels and/or a proper units of you will help your users making sense of your graphs. Using **data links** allows you to
make it easy to navigate through your dashboards.

---
## [< previous](01%20-%20Intro%20Grafana%20Prom%20QL.md) | [next >](03%20-%20Label%20Operators.md)
