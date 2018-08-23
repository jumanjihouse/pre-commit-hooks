#!/bin/sh
set -eu

################################################################################
# Ensure shell scripts conform to style guide.
################################################################################

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
  set -x
fi

if ! command -v shfmt >/dev/null 2>&1; then
  echo 'This check needs shfmt from https://github.com/mvdan/sh/releases'
  exit 1
fi

output="$(shfmt "$@" 2>&1)"
readonly output

if [ -n "${output}" ]; then
  echo "${output}"
  echo
  echo 'The above files have style errors.'
  exit 1
fi
