# Filtering
**Objective:** Understand time series filtering

Prometheus also supports binary operators that filter (discard) elements of an instant vector.
They can also give a boolean result, with 0 indicating false and 1 indicating true, 
when combined with the *bool* modifier. 

The following binary operators are supported:
* equal **==**
* not-equal **!=**
* greater-than **>**
* less-than **<**
* greater-or-equal **>=**
* less-or-equal **<=**

Let's look at some examples.
Given:
  * example{label="test"} = 0.7
  * example{label="test2"} = 1.3
  * example{label="test3"} = 0.4

the result of `example > 1.0` is:
  * example{label="test2"} = 1.3

the result of `example > bool 1.0` is:
  * example{label="test"} = 0
  * example{label="test2"} = 1
  * example{label="test3"} = 0

This filtering functionality is used a lot when writing alert rules, when you want to set limits or 
verify a situation to be true or false.

### Assignment
Adjust the previous graph with api_request_count to only show a value where it is above 150.

<details>
  <summary>Show solution</summary>

  **Solution**. You should have filled in: ```rate(api_request_count[1m])*10 > 150```
</details>

