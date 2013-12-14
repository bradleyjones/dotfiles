#!/usr/bin/python
import subprocess
def get_password(account=None):
    command = "gnome-keyring-query get %s" % account
    output = subprocess.check_output(command, shell=True)

    #strip out any newline characters
    output = output.rstrip('\n')
    return output

