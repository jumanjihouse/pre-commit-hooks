#!/bin/sh
set -eu
set -o pipefail

################################################################################
# Ensure shell scripts conform to shellcheck.
################################################################################

readonly DEBUG=${DEBUG:-0}
if [ "${DEBUG}" -ne 0 ]; then
  set -x
fi

shellcheck "$@"
