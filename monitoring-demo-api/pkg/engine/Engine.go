package engine

import (
	"time"

	"github.com/jberny/monitoring-demo-api/pkg/metric"
)

// Opts contains options to configure the engine.Run
type Opts struct {
	Interval  time.Duration
	Metric    metric.Metric
}

// Run executes a Task with configured interval
func Run(o Opts) {
	go func() {
		for {
			for _, lbls := range o.Metric.Labels {
				val := o.Metric.Generator.NextVal()
				alterMetric(o.Metric, val, lbls)
			}
			time.Sleep(o.Interval)
		}
	}()
}

func alterMetric(m metric.Metric, val float64, lv []string)  {
	if m.Counters != nil {
		c, err := m.Counters.GetMetricWithLabelValues(lv...)
		if err == nil {
			c.Add(val)
		}
	} else if m.Gauges != nil {
		g, err := m.Gauges.GetMetricWithLabelValues(lv...)
		if err == nil {
			g.Set(val)
		}
	} else if m.Summary != nil {
		s, err := m.Summary.GetMetricWithLabelValues(lv...)
		if err == nil {
			s.Observe(val)
		}
	} else if m.Histogram != nil {
		s, err := m.Histogram.GetMetricWithLabelValues(lv...)
		if err == nil {
			s.Observe(val)
			
		}
	} else {
		return
	}
}
