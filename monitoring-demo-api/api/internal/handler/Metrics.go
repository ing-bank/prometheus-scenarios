package handler

import (
	"net/http"
	"time"

	"github.com/jberny/monitoring-demo-api/pkg/engine"
	"github.com/jberny/monitoring-demo-api/pkg/generator"
	"github.com/jberny/monitoring-demo-api/pkg/metric"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var labels = map[string][]string{
	"country": {"nl", "it", "de", "fr"},
	"url":     {"/api", "/api/users", "/api/books/naked-sun", "/api/authors/isaac-asimov"},
	"service": {"users", "authors", "books"},
	"status":  {"SUCCESS", "FAILURE", "ERROR"},
	"method":  {"get", "post"},
	"code":    {"200", "404", "500"},
}

func combine(a []string, b []string) map[string][]string {
	result := make(map[string][]string)
	for _, elA := range a {
		for _, elB := range b {
			combo := []string{}
			if len(elA) > 0 {
				combo = append(combo, elA)
			}
			if len(elB) > 0 {
				combo = append(combo, elB)
			}
			result[elA+elB] = combo
		}
	}
	return result
}

var metrics = metric.Metrics{
	metric.Metric{
		Counters: promauto.NewCounterVec(
			prometheus.CounterOpts{
				Help: "Total count of requests",
				Name: "api_request_count",
			},
			[]string{"country"},
		),
		Generator: generator.Rand{Max: 30},
		Labels: combine([]string{""}, labels["country"]),
	},
	metric.Metric{
		Counters: promauto.NewCounterVec(
			prometheus.CounterOpts{
				Help: "Count of the status of each response",
				Name: "api_response_status_count",
			},
			[]string{"status", "country"},
		),
		Generator: generator.Rand{Max: 23},
		Labels:    combine(labels["status"], labels["country"]),
	},
	metric.Metric{
		Gauges: promauto.NewGaugeVec(
			prometheus.GaugeOpts{
				Help: "Nr of customers currently logged on",
				Name: "logged_on_customers",
			},
			[]string{"country"},
		),
		Generator: generator.NewLoggedOnCustomers(),
		Labels: combine([]string{""}, labels["country"]),
	},
	metric.Metric{
		Summary: promauto.NewSummaryVec(
			prometheus.SummaryOpts{
				Help:       "Total time in seconds that it takes to the api to fulfill a request",
				Name:       "api_request_duration_seconds",
				Objectives: map[float64]float64{0.99: 0.1, 0.95: 0.2, 0.5: 0.3},
			},
			[]string{"url"},
		),
		Generator: generator.APIRequestDuration{},
		Labels: combine([]string{""}, labels["url"]),
	},
	metric.Metric{
		Histogram: promauto.NewHistogramVec(
			prometheus.HistogramOpts{
				Help:    "Total time in seconds that it takes to invoke a service and receive a response",
				Name:    "service_request_duration_seconds",
				Buckets: []float64{0.1, 0.2, 0.5},
			},
			[]string{"service"},
		),
		Generator: generator.ServiceRequestDuration{
			Mean: 0.8,
			Deviation: 9,
		},
		Labels: combine([]string{""}, labels["service"]),
	},
}

// NewMetrics creates and initializes the Metrics http handler
// with all the metric definitions and starts generating them
func NewMetrics() http.Handler {
	for _, metric := range metrics {
		opts := engine.Opts{
			Interval: 1 * time.Second,
			Metric:   metric,
		}
		engine.Run(opts)
	}
	return promhttp.Handler()
}
