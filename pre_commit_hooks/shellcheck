#!/bin/sh
set -eu

################################################################################
# Ensure shell scripts conform to shellcheck.
################################################################################

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
  set -x
fi

shellcheck "$@"
