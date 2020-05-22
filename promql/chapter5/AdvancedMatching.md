# Advanced Matching

## Assignment 15
For the advanced matching topic we also added some recording rules to prometheus. A recording rule is frequently used to derive a metric from other metrics by aggregating over a number of dimensions and performing some transformations. Prometheus developers suggest a naming standard for these derived metrics (https://prometheus.io/docs/practices/rules/) that allow you to see the remaining dimensions, the original metric and the transformations performed. If you have a metric called http_errors that have labels for the web server instance, the method, the code (resulting http code) and the URL, you can perform the following transformation:
> sum(rate(http_errors[5m])) by (method,code)

The standardised name for this derived metric would be:
> method_code:http_errors:rate5m

In short, the derived metric name starts with the remaining labels, a colon, the name of the original metric, a colon and the transformation that has been applied. Sum is normally not mentioned in the transformation since it is almost always present.


Matching labels on the left-hand side and right-hand side of an operation normally requires the exact same labels + values on both sides, however this is sometimes not desired. Take for example metrics like:
> method_code:http_errors:rate5m{method="get", code="500"}
> method:http_requests:rate5m{method="get"}


Dividing the error rate by the request rate would give you the fraction of the requests that gave an error, but plain division won't work since they don’t have identical sets of labels. You can however tell Prometheus to either ignore the 'code' label or tell it to just use the 'method' label to do the operation normally:
> method_code:http_errors:rate5m{code="500"} / ignoring(code) method:http_requests:rate5m
> method_code:http_errors:rate5m{code="500"} / on(method) method:http_requests:rate5m


We have added two recording rules to the test environment, resulting in metrics called:
> function:api_calls:rate1m
> function_result:api_calls:rate1m

**Objective:**
Learn how to use ignoring/on
  * Use 'function:api_calls:rate1m' and 'function_result:api_calls:rate1m'
  * Make a graph showing the percentage of 'api_calls' that is in error for each function

<details>
  <summary>Show solution</summary>

  ## Solution 15
  You should have filled in: ```function_result:api_calls:rate1m{result="ERROR"} / ignoring(result) function:api_calls:rate1m```
  ![assignment15-1](./chapter2/assignment15-1.png)

  Change the left axis to show percentages based on a fraction and make sure the minimum and maximum value are specified:
  ![assignment15-2](./chapter2/assignment15-2.png)

  The graph should look similar to this:
  ![assignment15-3](./chapter2/assignment15-3.png)
</details>

## Assignment 16
If you want the same to be done for each status code, you will need something more. Grouping comes to the rescue. Rewriting the query with 'group_left':
> method_code:http_errors:rate5m / ignoring(code) group_left method:http_requests:rate5m

The above will result in a fraction for each error code. The alternative is 'group_right' you need to use this  when there are more than one series on the right side of the operator.

**Objective:**
Learn how to use grouping
  * Use 'function:api_calls:rate1m' and 'function_result:api_calls:rate1m'
  * Make a dashboard that shows a graph for each function with the percentage of calls with a given result

<details>
  <summary>Show solution</summary>

  ## Solution 16
  You need a variable Function with label_values(function) as a query:
  ![assignment16-1](./chapter2/assignment16-1.png)

  You should have filled in: ```function_result:api_calls:rate1m / ignoring(result) group_left(function) function:api_calls:rate1m```
  ![assignment16-2](./chapter2/assignment16-2.png)

  The dashboard should look similar to this (after it has been saved and reloaded):
  ![assignment16-3](./chapter2/assignment16-3.png)

  Note that this graph has a 30 min time frame instead of the default 15 min.
</details>
