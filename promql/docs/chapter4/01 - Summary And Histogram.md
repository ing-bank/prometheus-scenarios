# Summary and Histograms
**Objective:**  learn how to work with Summary and Histogram.

The Gauge and Counter type metrics are not the only types supported by Prometheus.
There are also the Summary and the Histogram that are used to **observe** values.
These 2 types of metrics are actually a collection of individual metrics.
It's simple to recognize them from the way they are built, which will be explained later.

Before moving on, let's take a moment to understand what is a *quantile*. 
This will be shortly useful, but if you already know it, you can skip this paragraph.
In statistics, a quantile is the value where an array of values can be divided into subgroups of equal size.
*Percentiles* are quantiles that divide an array of values into 100 equal parts.
If this is still unclear, try to this of the quantile as an answer to the following question:
what's the number in the given set of data that is greater than X percent of the values in the set.
For example, you need to find the 0.2 quantile to know the value in a set that is greater than 20% of the values in the set.

You can use both histograms and summaries to calculate quantiles. 
The main consideration is that summaries are more expensive for the client.
See the [Prometheus documentation](https://prometheus.io/docs/practices/histograms/#quantiles) for more details.

## Summary
Summary metrics are used to track the size of events. Usually, how long they take (e.g. a request-response duration). 
It consists of two counters, and some optional gauges. 
Mind that these are **all different metrics** even though they belong to the same summary. 
The two counters are named after the summary with the suffix *_count* and *_sum*.  
The _count metric counts the total number of times that the event has been observed.
The _sum is a sum of all the observed values.
The gauges are used to keep track of quantiles.

When monitoring applications, you use summaries to keep track of the duration of operations, e.g. serving a request.
For example, if your application received 5 requests which took 2 seconds each to get a reply, then your summary
will have a _count metric with the value 5 and an _sum metric with the value 10 (5 requests * 2 seconds).

The demo api exposes a metric called *api_request_duration_seconds* that has a label *url* and provides the 50%, 90% and 95% 
quantiles. This will result in the following 5 time series for each function:

```
api_request_duration_seconds_count{url="some-url"}
api_request_duration_seconds_sum{url="some-url"}
api_request_duration_seconds{url="some-url",quantile="0.5"}
api_request_duration_seconds{url="some-url",quantile="0.9"}
api_request_duration_seconds{url="some-url",quantile="0.95"}
```
This metrics will basically tell you: how long your application takes to fulfill incoming requests in 95%, 90% and 50% of the cases. 

### Assignment
Make a dashboard showing the 3 urls that have the lowest average call duration *in the last minute* at any given time.

<details>
  <summary>Show solution</summary>

  **Solution**. You should have filled in:
  You should have filled in:  ```bottomk(3,rate(api_request_duration_seconds_sum[1m]) / rate(api_request_duration_seconds_count[1m]))```
    
  Since api_request_duration_seconds_sum and api_request_duration_seconds are counters, you need to use the rate function
  to be able to divide their values in the last minute. That gives you the average per url. The `bottomk` function returns only the `k` lowest values.

</details>



## Histogram

This type of metric is very similar to the summary. The histogram has a _count and _sum too, plus optional counters instead of gauges. 
The counters are called *buckets* and are limited by an upper bound (inclusive). 
The buckets are used to count the total number of events that occurred within that boundary. 
The buckets are named after the summary name with the *_bucket* suffix and they have a label *le* (short for less or equal) 
that shows the upper bound.
By default, Prometheus creates a bucket with upper bound +infinite. That corresponds to the _count metric, so the total count of events.

Prometheus has a function called [histogram_quantile](https://prometheus.io/docs/prometheus/latest/querying/functions/#histogram_quantile)
that lets you calculate a quantile from and histogram. 
For example, if you want the 90th percentile for an *service_request_duration_seconds* metric over a *10 minutes* window, you would write a query like:
`histogram_quantile(0.9, rate(service_request_duration_seconds[10m]))`
If this is still

When monitoring applications, histograms are useful to see if your application meets specific objectives. 
You can then use the value of the bucket divided by the total count to get the percentage of requests that matches the objective.
In Prometheus terms this is called [Apdex Score](https://prometheus.io/docs/practices/histograms/#apdex-score), while site 
reliability engineers usually call this Service Level Objective.

The demo api has a histogram called `service_request_duration_seconds`, which results in the following metrics:
```
service_request_duration_seconds_count{service="some-service"}
service_request_duration_seconds_sum{service="some-service"}
service_request_duration_seconds{service="some-service",le="0.1"}
service_request_duration_seconds{service="some-service",le="0.2"}
service_request_duration_seconds{service="some-service",le="+Inf"}
```

### Assignment
Make a dashboard showing the median (50-percentile), 90-percentile and 95-percentile of service_request_duration_seconds for the last 10 minutes. 
Show each result in a different panel.

<details>
  <summary>Show solution</summary>

  **Solution**.  
  You should have created a variable called service with value: `label_values(service)`.  

  You should have filled in 3 queries:
  ```
  histogram_quantile(0.5, sum(rate(service_request_duration_seconds_bucket{service=~"$service"}[10m])) by (le))
  histogram_quantile(0.9, sum(rate(service_request_duration_seconds_bucket{service=~"$service"}[10m])) by (le))
  histogram_quantile(0.95, sum(rate(service_request_duration_seconds_bucket{service=~"$service"}[10m])) by (le))
  ```
</details>

---
## [< previous](README.md) | [next >](..)
