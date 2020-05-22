# Filtering and operators

## Assignment 12
Prometheus allows the use of operators for addition(+), subtraction(-), multiplication(\*), division(/), modulo(%) and exponentiation(^). These operators can act between two scalars where it yields the resulting in a new scalar value. However, when you use these operators between an instant-vector and a scalar the result will be a new instant vector (i.e. the values of multiple time series on a single point-in-time) and the operation will be performed on each individual value. Lastly , when applying an operation between two instant vectors you are combining time series. This will result is an instant vector containing a value for the left-hand side where a matching entry of the right hand side has been applied. Left-hand side entries without matching right-hand side entries are not in the result.

See the following example:
  * example1{label="test"} = 0.7
  * example1{label="test2"} = 1.3
  * example2{label="test"} = 0.4

The result of example1 + example2 would be:
  * {label="test"} = 1.1

Note that the example1 with the label test2 is ignored because the instant vectors did not match.

**Objective:**
Use multiplication in a graph
  * Use the 'logons' metric
  * Change a graph with logons per second to show logons per minute

<details>
  <summary>Show solution</summary>
  
  ## Solution 12
  You should have filled in: ```rate(logons[1m])*60```
  ![assignment12-1](./chapter2/assignment12-1.png)

  The graph should look similar to this:
  ![assignment12-2](./chapter2/assignment12-2.png)
</details>

## Assignment 13
Prometheus also supports binary operators that filter by default (i.e. can discard elements of an instant vector), but they can also act to give a boolean result with 0 indicating false and 1 indicating true (by adding the bool keyword). The following binary operators are supported:
> equal (==)
> not-equal (!=)
> greater-than (>)
> less-than (<)
> greater-or-equal (>=)
> less-or-equal (<=)

Given:
  * example{label="test"} = 0.7
  * example{label="test2"} = 1.3
  * example{label="test3"} = 0.4

the result of example > 1.0 is:
  * example{label="test2"} = 1.3

the result of example > bool 1.0 is:
  * example{label="test"} = 0
  * example{label="test2"} = 1
  * example{label="test3"} = 0

This filtering functionality also comes back a lot when writing alert rules when you want to set limits or verify a situation to be true or false.

**Objective:**
Understand time series filtering
  * Adjust the graph with logons per minute to only show a value where it is above 1000

<details>
  <summary>Show solution</summary>

  ## Solution 13
  You should have filled in: ```rate(logons[1m])*60 > 1000```
  ![assignment13-1](./chapter2/assignment13-1.png)

  The graph should look similar to this:
  ![assignment13-2](./chapter2/assignment13-2.png)
</details>

## Assignment 14
So far we only used one statement, but Prometheus also supports three set operations that are only defined between instant vectors, these are:
> intersection (and)
> union (or)
> complement (unless)


With intersection the result of "vector1 and vector2" consists of the elements of vector1 that have an element with corresponding labels in vector2.

With a union the result of "vector1 or vector2" consists of all elements of vector1 with all elements of vector2 that have a set of labels that does not exist in vector1 added to it.

With the complement the result of "vector1 unless vector2" consists of only those elements in vector1 that do not have a matching element in vector2.

**Objective:**
Learn of filtering by combining metrics
  * Make a graph showing where the 'api_call_duration' 90th-percentile value is above 300ms but only if the number of requests per second was greater than 1

<details>
  <summary>Show solution</summary>

  ## Solution 14
  You should have filled in: ```histogram_quantile(0.9, rate(service_call_duration_bucket[1m])) > 0.3 and rate(service_call_duration_count[1m]) > 1```
  ![assignment14-1](./chapter2/assignment14-1.png)

  The graph should look similar to this:
  ![assignment14-2](./chapter2/assignment14-2.png)
</details>
