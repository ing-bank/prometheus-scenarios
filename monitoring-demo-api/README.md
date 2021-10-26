# Monitoring Demo API

This Go api generates some sample prometheus metrics.

## Metrics
All the metrics generate a value per label every second.

### Logged On Customers
This metric is a counter that simulates the usual trend of users visiting a website.
It uses a sine function with a period of 15 minutes, a random generator and an offset 
to keep all the values positive and somewhat aleatory.

### Api Request Count
This is a gauge that generates random values to simulate a load of requests on the api.

### Api Request Duration Seconds
This is a summary that represents the total time in seconds that it takes to the api to fulfill a request.

## Development
set the GOPRIVATE=github.com/jberny

build with the build.sh script or usign the docker file.