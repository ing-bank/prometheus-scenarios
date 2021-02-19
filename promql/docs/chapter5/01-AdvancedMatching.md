**Objective:** learn how to use ignoring, on, group_left and group_right.

## One-to-one matching
Matching labels on the left-hand side and right-hand side of an operation normally requires the exact same label-value pairs on both sides, however this is sometimes not desired. 
Take for example metrics the ones below.
```
method_code:http_errors:rate5m{method="get", code="500"}
method:http_requests:rate5m{method="get"}
```
There is no point in having a label for status code in the second one.

Dividing the error rate by the request rate would give you the fraction of the requests that gave an error, but plain division won't work since they don’t have identical sets of labels. You can however tell Prometheus to either ignore the *code* label or tell it to just use the *method* label to do the operation normally:
```
method_code:http_errors:rate5m{code="500"} / ignoring(code) method:http_requests:rate5m
method_code:http_errors:rate5m{code="500"} / on(method) method:http_requests:rate5m
```

### Assignemnt
Make a graph showing the percentage of api requests that responded with an error.
Do this in one query and use `api_response_status_count` and `api_request_count`.

<details>
  <summary>Show solution</summary>

  **Solution**. You should have filled in: 
  ```sum(rate(api_response_status_count{status="ERROR"}[5m])) by (country) / sum(rate(api_request_count[5m])) by (country)```
</details>

## Many-to-one
If you want the same to be done for each status code, you will need something more. Grouping comes to the rescue. Rewriting the query with 'group_left':
*method_code:http_errors:rate5m / ignoring(code) group_left method:http_requests:rate5m

The above will result in a fraction for each error code. The alternative is 'group_right' you need to use this  when there are more than one series on the right side of the operator.

### Assignment
Make a dashboard that shows the percentage of all api request statuses for each country.
Do this in one query and use `api_response_status_count` and `api_request_count`.
*The demo api generates random numbers, so if you sum the SUCCESS, ERROR and FAILURE the percentages will not add up to exactly 100%.*

<details>
  <summary>Show solution</summary>

  **Solution**.
  You should have filled in: ```sum(rate(api_response_status_count[5m])) by (country,status) / ignoring(status) group_left sum(rate(api_request_count[5m])) by (country) ```
</details>


[Next >](../finish.md)