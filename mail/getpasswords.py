#!/usr/bin/python
import subprocess, os
def get_password(acct):
    acct = os.path.basename(acct)
    path = "/home/bradley/.passwd/%s.gpg" % acct
    args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""


   # command = "gnome-keyring-query get %s" % account
   # output = subprocess.check_output(command, shell=True)

    #strip out any newline characters
   # output = output.rstrip('\n')
   # return output

