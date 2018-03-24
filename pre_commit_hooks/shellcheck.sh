#!/bin/bash
set -eEu
set -o pipefail

################################################################################
# Ensure shell scripts conform to shellcheck.
################################################################################

readonly DEBUG=${DEBUG:-0}
if [[ ${DEBUG} -ne 0 ]]; then
  set -x
fi

is_shell_script() {
  local -r file="$1"
  local -i RC=1

  if file --mime --dereference "${file}" | grep 'shellscript' &> /dev/null; then
    RC=0
  elif [[ "${file}" =~ \.[ck]{0,1}sh$ ]]; then
    RC=0
  fi

  return ${RC}
}

declare -a file_list
for file in "$@"; do
  if is_shell_script "${file}"; then
    file_list+=("${file}")
  fi
done

if [[ ${#file_list[@]} -gt 0 ]]; then
  shellcheck -e SC1091 "${file_list[@]}"
fi
