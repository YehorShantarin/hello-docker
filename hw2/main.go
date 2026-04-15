package main

import (
	"fmt"
	"log"
	"net/http"
)

var (
	version   = "dev"
	commit    = "unknown"
	buildDate = "unknown"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from Docker\n\nversion: %s\ncommit:  %s\nbuilt:   %s\n",
		version, commit, buildDate)
}

func main() {
	http.HandleFunc("/", helloHandler)

	log.Printf("starting server on :8080 (version=%s commit=%s built=%s)",
		version, commit, buildDate)

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}