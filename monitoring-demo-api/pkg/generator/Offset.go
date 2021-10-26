package generator

type Offset struct {
	Internal Generator
	Offset   float64
}

func (o Offset) NextVal() float64 {
	return o.Internal.NextVal() + o.Offset
}