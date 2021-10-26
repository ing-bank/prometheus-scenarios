package controller

import (
	"net/http"
	"time"

	"github.com/google/logger"
	"github.com/jberny/monitoring-demo-api/api/internal/handler"

	"github.com/gorilla/mux"
)

//Route represents a routing configuration
type Route struct {
    Name        string
    Method      string
    Pattern     string
    Handler     http.Handler
}

//Routes is a slice of routes
type Routes []Route
 
//NewRouter creates a new mux.Router based on the existing Routes
func NewRouter() *mux.Router {
 
    router := mux.NewRouter().StrictSlash(true)
    for _, route := range routes {

        handler := accessLogger(route.Handler, route.Name)

        router.
            Methods(route.Method).
            Path(route.Pattern).
            Name(route.Name).
            Handler(handler)
    }
 
    return router
}


var routes = Routes{
    Route{ "Default","GET","/", handler.Default{}, },
    Route{ "Metrics","GET","/metrics", handler.NewMetrics(), },
}

func accessLogger(inner http.Handler, name string) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()

        inner.ServeHTTP(w, r)

        logger.Infof(
            "%s\t%s\t%s\t%s",
            r.Method,
            r.RequestURI,
            name,
            time.Since(start),
        )
    })
}

 