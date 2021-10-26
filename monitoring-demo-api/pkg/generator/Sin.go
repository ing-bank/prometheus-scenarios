package generator

import (
	"math"
	"time"
)

// Sin implements Generator
type Sin struct {
	ts     time.Time
	Period time.Duration
	Ray    float64
}

// NewSin creates a new Sin generator with initial timestamp
func NewSin(period time.Duration, ray float64) *Sin {
	return &Sin{
		ts:     time.Now(),
		Period: period,
		Ray:    ray,
	}
}

// NextVal generates values from a sin function
func (s *Sin) NextVal() float64 {
	now := time.Now()
	dur := now.Sub(s.ts).Seconds()
	radSec := (2.0 * math.Pi) / s.Period.Seconds()
	return s.Ray * math.Sin(radSec * dur)
}

// PositiveSin implements Generator
type PositiveSin struct {
	Sin    Sin
	Offset int
}