# Operators
**Objective:** learn how to use operators.

Prometheus allows the use of operators for addition(+), subtraction(-), multiplication(\*), division(/), modulo(%) 
and exponentiation(^). These operators can act between two scalars where it yields the resulting in a new scalar value. 
However, when you use these operators between an instant-vector and a scalar the result will be a new instant vector 
and the operation will be performed on each individual value. 
Lastly , when applying an operation between two instant vectors you are combining time series. 
This will result is an instant vector containing a value for the left-hand side where a matching label of 
the right hand side has been found. Left-hand side entries without matching right-hand side entries are not in the result.

See the following example:
  * example1{label="test"} = 0.7
  * example1{label="test2"} = 1.3
  * example2{label="test"} = 0.4

The result of example1 + example2 would be:
  * {label="test"} = 1.1

Note that the example1 with the label test2 is ignored because the instant vectors did not have match in example2.

### Assignment
Use the api_request_count to show the rate of logged on customers multiplied by 10.

<details>
  <summary>Show solution</summary>
  
  **Solution**. You should have filled in: ```rate(api_request_count[1m])*10```


---
## [< previous](README.md) | [next >](02%20-%20Filtering.md)
