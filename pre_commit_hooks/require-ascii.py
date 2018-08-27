#!/usr/bin/env python

"""
require-ascii
"""

# http://python-future.org/compatible_idioms.html
from __future__ import print_function

import sys
import chardet

status = 0

for filename in sys.argv:
    fh = open(filename, 'rb')
    data = fh.read()
    dict = chardet.detect(data)
    fh.close

    if dict['encoding'] in (None, 'ascii'):
        result = '[OK]'
    else:
        result = '[ERROR]'
        status = 1

    # With `--verbose', pre-commit shows output regardless of exit status.
    # Without `--verbose', pre-commit only shows output when status != 0.
    print(result.ljust(8) + filename.ljust(50), end='')
    print(dict)

exit(status)
