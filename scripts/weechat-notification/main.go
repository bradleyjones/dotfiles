package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"strings"
)

var storage string = os.Getenv("HOME") + "/.weechat-notification"

func beep() {
	app := "/usr/bin/ffplay"

	arg0 := "-nodisp"
	arg1 := "-autoexit"
	arg2 := "/home/bradley/.sounds/knock_brush.mp3"

	cmd := exec.Command(app, arg0, arg1, arg2)
	_, err := cmd.Output()

	if err != nil {
		println(err.Error())
		return
	}
}

func desktop_notification(user, msg string) {
	app := "/usr/bin/dunstify"

	arg0 := "-t"
	arg1 := "10000"
	arg2 := user
	arg3 := msg

	cmd := exec.Command(app, arg0, arg1, arg2, arg3)
	_, err := cmd.Output()

	if err != nil {
		println(err.Error())
		return
	}
}

func main() {
	if len(os.Args) < 2 {
		println("A command is required 'set' or 'show'")
		os.Exit(1)
	}

	switch os.Args[1] {
	case "set":
		if len(os.Args) < 4 {
			println("Not enough arguments provided... set {NAME} {MSG}")
			os.Exit(1)
		}

		file, err := os.Create(storage)
		if err != nil {
			println("Cannot create notification file", err)
			os.Exit(1)
		}
		defer file.Close()

		user := os.Args[2]
		msg := strings.Join(os.Args[3:], " ")

		fmt.Fprintf(file, user+": "+msg)
		beep()
		desktop_notification(user, msg)
	case "show":
		contents, err := ioutil.ReadFile(storage)
		if err != nil {
			println("Could not open notification file", err)
			os.Exit(1)
		}
		// Only show first n chars of message
		//if len(contents) >= 54 {
		//contents = contents[0:54]
		//}
		fmt.Println(string(contents))
	case "clear":
		file, err := os.Create(storage)
		if err != nil {
			println("Cannot clear notification file", err)
			os.Exit(1)
		}
		defer file.Close()
		fmt.Fprintf(file, "")

	default:
		println("A command is required 'set' or 'show'")
		os.Exit(1)
	}

	os.Exit(0)
}
