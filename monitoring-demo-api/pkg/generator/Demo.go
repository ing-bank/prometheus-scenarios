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

// APIRequestDuration demo generator, 
// represents the total time in seconds that it takes to the api to fulfill a request
// implements Generator interface
type APIRequestDuration struct {}

// NextVal returns next value 
func (a APIRequestDuration) NextVal() float64 {
	return rand.Float64()
}

// ServiceRequestDuration demo generator, 
// represents the total time in seconds that it takes to the api to fulfill a request
// implements Generator interface
type ServiceRequestDuration struct {
	Mean       float64
	Deviation  float64
}

// NextVal returns next value 
func (a ServiceRequestDuration) NextVal() float64 {
	return rand.NormFloat64() * a.Deviation + a.Mean
}
