# Grafana Panels

## Title
In the previous step, Grafana created a panel to let you input your query. That comes with 
### Title - Assignment 
Use the **Legend format** to display each 

## Legend
You might have noticed that your legend for the **logged_on_customers** metric looks messy. That happens because Prometheus gives
back a value for every unique combination of the label values in the metric. If you want your visualization to look slightly better,
you can adjust the way the time series is called using the option **Legend format** under your query line. 
This field takes both static text or label values. To use label values, you need to put the label name between "{{" and "}}".

Grafana does not care about the uniqueness of names so take care to select appropriate labels or the result may end up highly 
confusing. 

### Legend - Assignment 
Use the **Legend format** to display each 

## Resolution
The Resolution field is used to determine how many datapoints Grafana should receive from Prometheus. The default is 1/1 which 
means that Grafana tries to plot every datapoint to a pixel. With 1/2 Grafana will try to get a data point for each 2 pixels. 
By changing the resolution, you can smoothen the lines on the graph. 

## Conclusion
By adjusting the title, labels and/or a proper units of you will help your users making sense
of your graphs.
