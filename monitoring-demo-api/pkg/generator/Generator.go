package generator

// Generator generates a sequence of values
type Generator interface {
	// NextVal returns the next value in the sequence
	NextVal() float64
}