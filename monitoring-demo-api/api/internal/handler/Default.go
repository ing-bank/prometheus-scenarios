package handler

import (
	"net/http"

	"github.com/google/logger"
)

// Default implements http.Handler interface
type Default struct {}

// ServeHTTP prints default webpage
func (d Default) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(302)
	w.Header().Add("Content-Type", "text/plain")
	w.Header().Add("Location", "/")
	if _, err := w.Write([]byte("Redirecting to /metrics")); err != nil {
		logger.Errorf(
			"%v",
			err,
		)
	}
}