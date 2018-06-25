package main

import (
	"flag"
	"fmt"
	"os"
	"net/http"
	"bytes"
	"encoding/json"
)

const (
	DefaultHTTPAddr = "127.0.0.1:11000"
)

// Command line parameters
var httpAddr string

func init() {
	flag.StringVar(&httpAddr, "host", DefaultHTTPAddr, "http server for api")
	flag.Usage = func() {
		fmt.Printf("Usage: -host [get|set] [key] [value (optional)]\n")
		flag.PrintDefaults()
	}
}

func main() {
	flag.Parse()

	method := flag.Arg(0)
	key := flag.Arg(1)

	switch method {
	case "get":
		response, err := http.Get(fmt.Sprintf("http://%s/key/%s", httpAddr, key))
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}
		buf := new(bytes.Buffer)
		buf.ReadFrom(response.Body)
		body := buf.String()
		fmt.Printf("%s: %s", key, body)

	case "set":
		jsonMap := map[string]string{}
		value := flag.Arg(2)
		jsonMap[key] = value
		jsonValues, err := json.Marshal(jsonMap)
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}

		req, err := http.NewRequest("POST", fmt.Sprintf("http://%s/key", httpAddr), bytes.NewReader(jsonValues))
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}
		client := &http.Client{}
		resp, err := client.Do(req)
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}
		buf := new(bytes.Buffer)
		buf.ReadFrom(resp.Body)
		body := buf.String()
		fmt.Printf("%s: %s", key, body)
	case "delete":
		req, err := http.NewRequest("DELETE", fmt.Sprintf("http://%s/key/%s", httpAddr, key), nil)
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}
		client := &http.Client{}
		resp, err := client.Do(req)
		if err != nil {
			fmt.Print(err.Error())
			os.Exit(1)
		}
		buf := new(bytes.Buffer)
		buf.ReadFrom(resp.Body)
		body := buf.String()
		fmt.Printf("%s: %s", key, body)
	}
}
