package generator

import "math/rand"

// Rand implements Generator
type Rand struct {
	Max int32
}

func (r Rand) NextVal() float64 {
	return float64(rand.Int31n(r.Max))
}