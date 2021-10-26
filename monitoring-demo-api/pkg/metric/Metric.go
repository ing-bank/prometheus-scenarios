package metric

import (
	"github.com/jberny/monitoring-demo-api/pkg/generator"
	"github.com/prometheus/client_golang/prometheus"
)

// Metric represents a prometheus metric
type Metric struct {
	Counters    *prometheus.CounterVec
	Gauges 	    *prometheus.GaugeVec
	Summary     *prometheus.SummaryVec
	Histogram   *prometheus.HistogramVec
	Generator   generator.Generator
	Labels      map[string][]string
}

// Metrics an array of Metric
type Metrics []Metric

