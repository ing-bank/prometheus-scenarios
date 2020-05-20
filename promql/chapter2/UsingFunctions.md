# Using functions

## Assignment 5
Selecting a range vector in Prometheus is done by appending a time window specification between square brackets to your metric (for example: my_metric[1m] selects 1 minute). These ranges allow the use of all sorts of functions in Prometheus that manipulate the data.


You can also have prometheus calculate the change in the number of logged in customers using functions like delta() or deriv() .
  * delta : change in value between the first and last value of a time series in a range vector (time range)
  * idelta: change in value between the 2 last values of a time series in a range vector (time range)
  * derive: per-second derivative of a time series in range vector


These functions should only be used with GAUGES. Note that the idelta function is somewhat less useful as it depends on the scrape interval in order to give it meaning.

**Objective:**
Understand the delta(), deriv() and idelta() functions
  * Use the 'logged_on_customers' metric
  * Add a panel showing the per second change in the number of logged on customers for each site

<details>
  <summary>Show solution</summary>
  
  ## Solution 5
  You should have filled in: ```deriv(logged_on_customers{site='$site'}[1m])}```
  ![assignment5-1](./chapter2/assignment5-1.png)

  The graph should look similar to this:
  ![assignment5-2](./chapter2/assignment5-2.png)

  Note that this graph has a 30 min time frame instead of the default 15 min.

  The difference between Delta and Deriv:

  Delta shows you the **difference** between two points of time where the two valuables are subtracted from each other. These two valuables are selected based on the given time frame (in this case 1 min). On the other hand, Deriv (v range-vector) calculates the per-second **derivative** of the time series in a range vector v, using simple linear regression. Deriv calculates the slope of the graph.
</details>

## Assignment 6
Showing a snapshot value like this (i.e. current number of logged on customers) has some issues. For monitoring you would often be interested in the load on a system and that is more directly related to the number of logons and logoffs. These individual values cannot easily be derived from the 'logged_on_customers' metric, this is why counters are often used to determine load. The Function rate() is used to calculate the per-second average rate of increase for a time series. It automatically adjusts for a counter reset. There is also irate() which calculates the per-second average rate of increase for a time series based on the last two samples in a range vector. You should avoid using irate() unless it is for rapidly increasing values since the value will otherwise fluctuate wildly leading to a hard-to-read graph.

**Objective:**
Understand how to handle Counter type metrics using rate() or irate()
  * Use the metric 'logons' with label 'site' as a counter that counts up one for each logon
  * Create a dashboard showing the number of logons for each site and display the average number of logons per second in a one minute range vector

<details>
  <summary>Show solution</summary>

  ## Solution 6
  You should have filled in: ```rate(logons[1m])```
  ![assignment6-1](./chapter2/assignment6-1.png)

  The graph should look similar to this:
  ![assignment6-2](./chapter2/assignment6-2.png)
</details>

## Assignment 6b
When you zoom out very far something peculiar may happen (although on this test environment the most likely thing you'll notice is that there is no data older than 3 days). We specify that we want information averaged for a 1 minute time window but Grafana queries data from prometheus using a dynamic step size. Grafana does this to avoid fetching much more data than can actually be visualized on the screen. Thus if the step size ends up as 15 minutes the resulting graph would be highly misleading showing for 'api.ing.nl' values at either the high or the low value of the realistic view. Luckily Grafana does have a pseudo-variable available that helps in avoiding this problem: "$__interval", this value is the actual duration between two points that Grafana wants to plot and using it as a window specification in Prometheus will ensure that the resulting graph does not hide narrow features completely but of course it may end up flattening graphs since the time window gets larger when the graph is more zoomed out.

A dynamic interval can also be a problem when it gets too small (i.e. when the step size is less than or equal to the scrape frequency any rate() function will yield no results). To counter that you can specify the minimal step size instructing Grafana that the step size is not allowed to become less than values that actually yield results.

**Objective:**
Understand how to make a graph scalable
  * Use the minimal step size to ensure that the graph stays functioning when zoomed in very far
  * Adjust the graph so that it shows all information in the graph even when zoomed out very far

<details>
  <summary>Show solution</summary>

  ## Solution 6b
  The metric should have been:
  ![assignment6b-1](./chapter2/assignment6b-1.png)

  The graph should look similar to this:
  ![assignment6b-2](./chapter2/assignment6b-2.png)

  Zooming out to 20 days the graph would look like this:
  ![assignment6b-2](./chapter2/assignment6b-3.png)
</details>

## Assignment 7
It is also possible to aggregate metrics, using aggregation operators like 'sum', 'min', 'max', 'avg', 'bottomk', 'topk' and 'quantile'. These values operate on single instant vectors (i.e. the values of multiple time series on a single point-in-time). You can either aggregate over all dimensions or use' without(<labels>)' or 'by(<labels>)'. The 'without' statement removes the given labels, the 'by' statement retains only the given labels. When aggregating time series based on counters, make sure to take the rate() before aggregating.

**Objective:**
Understand how to use sum() to aggregate
  * Use the metric api_calls with labels 'function' and 'result', with 3 distinct values for result (SUCCESS, FAILURE and ERROR) and several different values for the label 'function'
  * Make a dashboard showing a per-second rate of all SUCCESS, FAILURE  and ERROR api_calls in a single graph

<details>
  <summary>Show solution</summary>

  ## Solution 7
  The metric should have been:
  ![assignment7-1](./chapter2/assignment7-1.png)

  The graph should look similar to this:
  ![assignment7-2](./chapter2/assignment7-2.png)
</details>

## Assignment 8
**Objective:**
Understand how to use topk() to select the highest datapoints at every instant
  * Make a dashboard showing a per-second rate of number of logons for the two sites with most logons

<details>
  <summary>Show solution</summary>

  ## Solution 8
  You should have filled in: ```topk(2,rate(logons[1m]))```
  ![assignment8-1](./chapter2/assignment8-1.png)

  The graph should look similar to this:
  ![assignment8-2](./chapter2/assignment8-2.png)
</details>

## Assignment 9
Prometheus also supports some aggregation functions where you do not aggregate over multiple time series but rather aggregate on one time series over time. These functions include avg_over_time(), min_over_time() max_over_time(), sum_over_time() and quantile_over_time(). These functions work on a range-vector.

**Objective:**
Understand how to calculate over-time aggregations
  * Make a dashboard showing graphs of the number of customers that was logged on for each site but smoothed as an average of the last 5 minutes

<details>
  <summary>Show solution</summary>

  ## Solution 9
  You should have filled in: ```avg_over_time(logged_on_customers[5m]```
  ![assignment9-1](./chapter2/assignment9-1.png)

  The graph should look similar to this:
  ![assignment9-2](./chapter2/assignment9-2.png)
</details>
