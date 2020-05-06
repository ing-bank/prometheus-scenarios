# Grafana Panels

**Objective:** understand how to use the Legend format to adjust the name of a time series and changing your graphs.

## Title
In the previous step, Grafana created a panel to let you input your query. That comes with 

### Title - Assignment 
Go to the General tab to change the Title of your graph and to the Axes tab to label your axes

## Legend
You might have noticed that your legend for the **logged_on_customers** metric looks messy. That happens because Prometheus gives
back a value for every unique combination of the label values in the metric. If you want your visualization to look slightly better,
you can adjust the way the time series is called using the option **Legend format** under your query line. 
This field takes both static text or label values. To use label values, you need to put the label name between "{{" and "}}".

Grafana does not care about the uniqueness of names so take care to select appropriate labels or the result may end up highly 
confusing. 

### Legend - Assignment 
Adjust the dashboard to show only the country code in the legend

## Resolution
The Resolution field is used to determine how many datapoints Grafana should receive from Prometheus. The default is 1/1 which 
means that Grafana tries to plot every datapoint to a pixel. With 1/2 Grafana will try to get a data point for each 2 pixels. 
By changing the resolution, you can smoothen the lines on the graph. 

## Conclusion
By adjusting the title, labels and/or a proper units of you will help your users making sense
of your graphs.
