# Grafana Variables
**Objective:** understand how to make a graph scalable.

### The $__interval Variable
When you zoom out very far something peculiar may happen (although on this test environment the most likely thing you'll notice 
is that there is no data older than when you started). 
We specify that we want information averaged for a 1 minute time window, 
but Grafana queries data from prometheus using a dynamic step size.
Grafana does this to avoid fetching much more data than can actually be visualized on the screen.

Thus, if the step size ends up as 15 minutes, the resulting graph would have wrong values at either 
the high value or the low value of the realistic view.

Luckily, Grafana does have a pseudo-variable available that helps in avoiding this problem: *$__interval*, 
this value is the actual duration between two points that Grafana wants to plot. 
Using it as range specification in Prometheus will ensure that the resulting graph does not hide 
narrow features completely.
However, it may end up flattening graphs since the time window gets larger when the graph is more zoomed out.

A dynamic interval can also be a problem when it gets too small (i.e. when the step size is less than or equal to the scrape 
frequency any rate() function will yield no results). 
To counter that, you can specify the *minimal step size* instructing Grafana that the step size is not allowed 
to become less than values that actually yield results.


  * Use the minimal step size to ensure that the graph stays functioning when zoomed in very far
  * Adjust the graph so that it shows all information in the graph even when zoomed out very far


