package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

var storage string = os.Getenv("HOME") + "/.weechat-notification"

func main() {
	if len(os.Args) < 2 {
		fmt.Println("A command is required 'set' or 'show'")
		os.Exit(1)
	}

	switch os.Args[1] {
	case "set":
		if len(os.Args) < 4 {
			fmt.Println("Not enough arguments provided... set {NAME} {MSG}")
			os.Exit(1)
		}

		file, err := os.Create(storage)
		if err != nil {
			fmt.Println("Cannot create notification file", err)
			os.Exit(1)
		}
		defer file.Close()

		user := os.Args[2]
		msg := os.Args[3]

		// Only show first 15 chars of message
		if len(msg) >= 15 {
			msg = msg[0:15]
		}
		fmt.Fprintf(file, user+": "+msg)
	case "show":
		contents, err := ioutil.ReadFile(storage)
		if err != nil {
			fmt.Println("Could not open notification file", err)
			os.Exit(1)
		}
		fmt.Println(string(contents))
	default:
		fmt.Println("A command is required 'set' or 'show'")
		os.Exit(1)
	}

	os.Exit(0)
}
