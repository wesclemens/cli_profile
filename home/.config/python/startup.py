#!/usr/bin/env python

# This is to enable readline support in python2. This is done by default
# in python3. This can be removed in 2020 when python2 support is abandoned
import sys
if not hasattr(sys, '__interactivehook__'):
    try:
        import readline
    except ImportError:
        print("Module readline not available.")
    else:
        import rlcompleter
        import os
        import atexit
        readline.parse_and_bind("tab: complete")
        histfile = os.path.expanduser("~/.python_history")
        try:
            readline.read_history_file(histfile)
        except IOError:
            pass
        atexit.register(readline.write_history_file, histfile)
        del os, histfile, rlcompleter, atexit

# Make console output nicer
import pprint
sys.displayhook = pprint.pprint

del sys
