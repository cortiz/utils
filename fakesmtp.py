#!/bin/python3
from __future__ import print_function
from datetime import datetime
import asyncore
from smtpd import SMTPServer
import sys

class EmlServer(SMTPServer):
    no = 0
    def process_message(self, peer, mailfrom, rcpttos, data, **kwargs):
        print("Sender: {}".format(mailfrom))
        print("Recipients: {}".format(rcpttos))
        print("Body: {} \n".format(data.decode("UTF-8")))
        self.no += 1

def run(port):
    # start the smtp server on localhost:1025
    foo = EmlServer(('localhost', port), None)
    try:
        asyncore.loop()
    except KeyboardInterrupt:
        pass


if __name__ == '__main__':
    port = 2525
    if len(sys.argv) >=2:
        port = int(sys.argv[1])
    print("Starting at port {}".format(port))
    try: 
        run(port)
    except PermissionError:
        print("sudo is need to run on port {}".format(port))
