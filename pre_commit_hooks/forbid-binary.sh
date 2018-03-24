#!/bin/bash
set -eEu
set -o pipefail

################################################################################
# Forbid binary files.
################################################################################

readonly DEBUG=${DEBUG:-0}
if [[ ${DEBUG} -ne 0 ]]; then
  set -x
fi

is_binary() {
  local -r file="$1"
  local -i RC=1
  local output

  output="$(file --mime --dereference "${file}")"
  readonly output

  if [[ ${output} =~ inode/x-empty ]]; then
    : # Don't consider zero-sized file to be binary.
  elif [[ "$(stat -c %s "${file}")" =~ "^0$" ]]; then
    : # Don't consider zero-sized file to be binary.
  elif [[ ${output} =~ binary$ ]]; then
    RC=0
  fi

  return ${RC}
}

declare -a file_list=()
for file in "$@"; do
  if is_binary "${file}"; then
    file_list+=("${file}")
  fi
done

if [[ ${#file_list[@]} -gt 0 ]]; then
  echo "${file_list[@]}"
  exit 1
fi
