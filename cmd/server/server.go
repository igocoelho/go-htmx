package main

import (
	"log"
	"net/http"

	handler "com.igocoelho/go-htmx/handler"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /", handler.Home)

	log.Fatal(http.ListenAndServe(":8000", mux))
}
