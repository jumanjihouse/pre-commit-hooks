#!/bin/sh
set -eu

################################################################################
# Forbid spaces in indents.
################################################################################

readonly DEBUG=${DEBUG:-0}
if [ "${DEBUG}" -ne 0 ]; then
  set -x
fi

if grep -El '^ ' "$@"; then
  echo
  echo 'Found space(s) within indentation in the above file(s).'
  exit 1
fi
