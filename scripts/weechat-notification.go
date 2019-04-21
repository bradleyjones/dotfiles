package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
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
		msg := strings.Join(os.Args[3:], " ")

		fmt.Fprintf(file, user+": "+msg)
	case "show":
		contents, err := ioutil.ReadFile(storage)
		if err != nil {
			fmt.Println("Could not open notification file", err)
			os.Exit(1)
		}
		// Only show first n chars of message
		//if len(contents) >= 54 {
		//contents = contents[0:54]
		//}
		fmt.Println(string(contents))
	default:
		fmt.Println("A command is required 'set' or 'show'")
		os.Exit(1)
	}

	os.Exit(0)
}
