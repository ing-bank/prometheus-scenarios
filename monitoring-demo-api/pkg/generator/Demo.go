package generator

import (
	"math"
	"math/rand"
	"time"
)

// LoggedOnCustomers demo generator, simulates a trend of customers
// implements Generator interface
type LoggedOnCustomers struct {
	sin Sin
	rand Rand
}

// NewLoggedOnCustomers creates a LoggedOnCustomers struct
// initialized with a generator.Sin and a generator.Rand 
func NewLoggedOnCustomers() LoggedOnCustomers {
	return LoggedOnCustomers{
		sin: *NewSin(15*time.Minute, 50),
		rand: Rand{ Max: 20 },
	}
}

// NextVal returns next value 
func (r LoggedOnCustomers) NextVal() float64 {
	val := r.sin.NextVal() + 15
	offset := r.rand.NextVal()
	if val <= 0 {
		return offset
	} 
	return math.Round(val + offset)
}

// RequestDuration demo generator,
// represents the total time in seconds that a request takes. This value is distributed as a
// truncated normal distribution (negative values are nonsense and truncated to 0)
// implements Generator interface
type RequestDuration struct {
	Mean       float64
	Deviation  float64
}

// NextVal returns next value 
func (a RequestDuration) NextVal() float64 {
	result = rand.NormFloat64() * a.Deviation + a.Mean
	if result < 0 {
		result = 0
	}
	return result
}
