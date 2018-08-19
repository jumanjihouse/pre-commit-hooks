#!/usr/bin/env python

"""
require-ascii
"""

import sys
import chardet

status = 0

for filename in sys.argv:
    fh = open(filename, 'rb')
    data = fh.read()
    dict = chardet.detect(data)
    fh.close

    if dict['encoding'] in ('none', 'ascii'):
        result = '[OK]'
    else:
        result = '[ERROR]'
        status = 1

    # With `--verbose', pre-commit shows output regardless of exit status.
    # Without `--verbose', pre-commit only shows output when status != 0.
    print result.ljust(8) + filename.ljust(50),
    print dict

exit(status)
