# Using Functions
**Objective:** learn how and when to use PromQL functions.

## Instant Vectors and Range Vectors
When you submit a basic PromQL query, i.e. `up`, you get back a list of time series with their latest value. 
This is called an *Instant Vector*. Though, in a lot of cases, you will need to work with all the values in a certaine time frame.
For that purpose, you can use a *Range Vector*. Selecting a range vector in Prometheus is done by 
appending a time window specification between square brackets to your metric (for example: my_metric[1m] selects 1 minute).
These ranges allow the use of all sorts of functions in Prometheus that manipulate the data. 

To know what range that you can select is good enough, you need to know the *scrape_interval*.
That is how often Prometheus pulls the metrics from the targets. Depending on the scrape interval and function you are going to use,
you will get more accurate results with a larger range. 
For this demo, we set a scrape interval of 10s. Thus our Prometheus instance will collect 3 values every 30 seconds (30/10=3).
So a range of one minute is good enough for our demo.
Normally, you would have to configure this in Prometheus yourself. In case you don't know what's the value
you can see it in Prometheus UI under the Status menu, in the Configuration tab.

## Assignment
You can see the difference by using the query directly in Prometheus.
Go to the [Prometheus](http://localhost:9090/) 
web interface, query the `up` metric with and without range selector and observe the difference.


## Counters and Gauges
There are different metric types in Prometheus, the most simple are *Counter* and *Gauge*. 
The counter is a time series that always increases over time, while a gauge can assume any value over time.
It's important to know the type of metric you are working with because, you might get wrong results by applying the wrong function.


## Delta, Derive and Idelta functions
These functions should only be used with **gauges**.
* *delta*: change in value between the first and last value of a time series in a range vector (time range)
* *idelta*: change in value between the 2 last values of a time series in a range vector (time range)
* *deriv*: per-second derivative of a time series in range vector

Delta shows you the *difference* between two points in time where the two values are subtracted from each other. 
These two values are selected based on the given time frame (e.g. 1 min). 
On the other hand, deriv(v range-vector) calculates the per-second *derivative* of the time series in a range vector v,
using simple linear regression. In other words, deriv calculates the slope of the graph.
The idelta function is somewhat less useful as it depends on the scrape interval in order to give it meaning.

When monitoring an application, you may be interested in the number of users currently using you application.
Gauges are a good tool to measure it. The demo api has a metric called *logged_on_customers* that simulates exactly that.

### Assignment
Let's go back to [Grafana](http://localhost:3000/).
Add a panel showing the per second change in the number of logged on customers for each country.
Use a range of 1 minute.

<details>
  <summary>Show solution</summary>
  <p>

  **Solution**. You should have filled in: ```deriv(logged_on_customers{country="$country"}[1m])```
  
  </p>
</details>

## Rate and Irate
These functions should only be used with **counters**. They basically measure the same thing, but in different ways, 
thus they should be used in different situations.
* *rate*: is used to calculate the per-second average rate of increase for a time series
* *irate*: calculates the per-second average rate of increase for a time series based on the last two samples in a range vector.

You should avoid using irate() unless your metric increases rapidly.
Otherwise, the value will fluctuate wildly and will make your graph hard to read.

For monitoring you would often be interested in the load on a system. 
That is more directly related to the number (or count) of incoming requests. 
Counters suit to this purpose because their current value is the sum of all previous measurements,
unless your application stopped or restarted (in that case they are set back to zero).

The demo api exposes a metric called *api_request_count* that simulates a measurement of the number of incoming requests.

### Assignment
Create a dashboard showing the number of requests per second for all countries.
Use a range of 1 minute.

<details>
  <summary>Show solution</summary>
  
  **Solution**. You should have filled in: ```rate(api_request_count[1m])```
</details>

