**Objective:** learn how to user aggregators.

## Sum, Min, Max and Avg
Aggregators allow you to calculate a new vector from an existing one.
The aggregators can only be applied to instant vectors.

As the names suggests, the *sum*, *min*, *max* and *avg* will apply the corresponding calculation to
the vector and return the result as a new vector.

You can either aggregate over all labels or use *without(<labels>)* or *by(<labels>)* to filter them.
The 'without' statement removes the given labels, the 'by' statement retains only the given labels. 

When aggregating time series based on counters, make sure to take the rate() before aggregating.
You can read a detailed explaination [here](https://www.robustperception.io/rate-then-sum-never-sum-then-rate).

As an example, considering our demo api, the `avg(rate(logged_on_customers)[1m]) by (country)` would calculate an
instant vector that tells us the average (per minute) number of logged on customers for each country.

### Assignment
Use the metric *api_response_status_count* to make a dashboard showing a per-second rate of all 
SUCCESS, FAILURE and ERROR api calls in a single graph.

<details>
  <summary>Show solution</summary>
  
  **Solution.** The metric should have been: `sum(rate(api_response_status_count[1m]))`
</details>

## TopK and BottomK
The *topk* and *bottomk* operators are used to get respectively the highest and lowest k time series in the metric.

### Assignment
Make a dashboard showing a per-second rate of number api request for the two countries with the highest number of requests.

<details>
  <summary>Show solution</summary>

  **Solution.** You should have filled in: ```topk(2, rate(api_request_count[1m]))```
</details>

## Over-Time Aggregators
Prometheus also supports some aggregators where you do not aggregate over multiple time series,
but rather aggregate on one time series over time. 
These functions include *avg_over_time*, *min_over_time*, *max_over_time* and *sum_over_time*. 
These functions work on a range vector.

### Assignment
Make a dashboard showing graphs of the number of customers that was logged on for each site,
but smoothed as an average of the last 5 minutes.

<details>
  <summary>Show solution</summary>

  **Solution**. You should have filled in: ```avg_over_time(logged_on_customers[5m]```
</details>


## Other Aggregators
We can't cover all the aggregators here. We will focus on the easiest. For a complete list, 
see [Prometheus docs](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators).