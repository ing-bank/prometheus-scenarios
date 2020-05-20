**Objective:**  learn how to work with Summary and Histogram.

The Gauge and Counter type metrics are not the only ones that Prometheus supports.
There are also the Summary and the Histogram that are used to **observe** values. 

## Summary
Summary metrics are used to track the size of events, usually how long they take. 
It consists of two counters, and some optional gauges. 
Mind that these are **all different metrics** even though they belong to the same summary. 
The two counters are named after the summary with the suffix *_count* and *_sum*.  
The _count metric counts the total nr of times that the event has been observed.
The _sum is a sum of all the observed values.
The gauges are used to keep track of [quantiles](https://www.statisticshowto.com/quantile-definition-find-easy-steps/).

When monitoring appications, you use summaries to keep track of the duration of operations, i.e. serving a request.
Also, in combination with that you are tipically interested in the 0.5, 0.9 and 0.95 quantiles. 
In simple terms, this will tell you: how long your application takes to fulfill incoming requests 
in 95%, 90% and 50% of the cases. 

The demo api exposes a metric called *api_request_duration_seconds& that has a label country and provides the 50%, 90% and 95% 
quantiles. This will result in the following 5 time series for each function:
```
api_request_duration_seconds_count{country="some-country"}
api_request_duration_seconds_sum{country="some-country"}
api_request_duration_seconds{country="some-country",quantile="0.5"}
api_request_duration_seconds{country="some-country",quantile="0.9"}
api_request_duration_seconds{country="some-country",quantile="0.95"}
```

### Assignment
Make a dashboard showing the 3 countries that have the lowest average call duration *in the last minute* at any given time.

<details>
    <summary>Show solution</summary>
    
    **Solution.** You should have filled in: 
    `bottomk(3,rate(api_request_duration_seconds_sum[1m]) / rate(api_request_duration_seconds_count[1m]))`

    Since api_request_duration_seconds_sum and api_request_duration_seconds are counters, you need to use the rate function
    to be able to divide their values in the last minute. That gives you the average per country. 
    The `bottomk` function return only the n lowest values.
</details>

## Histogram

This type of metric is very similar to the summary. The histogram has a _count and _sum too, plus optional counters instead of gauges. 
The counters are called *buckets* and are limited by an upper bound (inclusive). 
The buckets are used to count the total number of events that occured within that boundary. 
The buckets are named after the summary name with the *_bucket* suffix and they have a label *le* (short for less or equal) 
that shows the upper bound.
By default, Prometheus creates a bucket with upper bound +infinite, that corresponds to the _count metric, so the total count of events.

Prometheus has a function called [histogram_quantile](https://prometheus.io/docs/prometheus/latest/querying/functions/#histogram_quantile)
that lets you calculate a quantile from and histogram. 
For example, if you want the 90th percentile for an example metric over a 10 minute window the query would be:
`histogram_quantile(0.9, rate(example_bucket[10m]))`

So, if You can get pretty much the same information from a summary and from an histogram, why should you use a histogram?
When monitoring applications, histograms are useful to see if your application meets specific objectives. 
For example, if you need to make sure that your application is serving 95% of the requests within 300ms, 
then you can define a bucket histogram with a bucket for 0.3. 
You can then use the value of the bucket divided by the total count to get the percentage of requests that matches the objective.
In Prometheus terms this is called [Apdex Score](https://prometheus.io/docs/practices/histograms/#apdex-score), while site 
reliability engineers usually call this Service Level Objective.

The demo api has a histogram called service_request_duration_seconds, which results in the following metrics:
```
service_request_duration_seconds_count{country="some-country"}
service_request_duration_seconds_sum{country="some-country"}
service_request_duration_seconds{country="some-country",le="100.0"}
service_request_duration_seconds{country="some-country",le="200.0"}
service_request_duration_seconds{country="some-country",le="+Inf"}
```

### Assignment
Make a dashboard showing the median 50-percentile, 90-percentile and 95-percentile of service_request_duration_seconds
for the last 10 minutes. Show each result in a different panel.

<details>
    <summary>Show solution</summary>
    
    **Solution.** You should have filled in 3 queries:
    ```
    histogram_quantile(0.5, rate(service_request_duration_seconds{country=~"$country"}[10m]))
    histogram_quantile(0.9, rate(service_request_duration_seconds{country=~"$country"}[10m]))
    histogram_quantile(0.95, rate(service_request_duration_seconds{country=~"$country"}[10m]))
    ```
</details>