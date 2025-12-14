#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

choices=("android" "ios" "quit")
selected=0

while true; do
  clear
  echo "Which build?"
  echo

  for i in "${!choices[@]}"; do
    if [[ $i -eq $selected ]]; then
      printf "> %s\n" "${choices[$i]}"
    else
      printf "  %s\n" "${choices[$i]}"
    fi
  done

  # Read single key (including arrow keys)
  IFS= read -rsn1 key

  # Handle arrow keys (escape sequences)
  if [[ $key == $'\x1b' ]]; then
    # Read the next two chars of the escape sequence
    IFS= read -rsn2 key
    case "$key" in
      "[A") # Up
        if [[ $selected -le 0 ]]; then
          selected=$((${#choices[@]} - 1))
        else
          selected=$((selected - 1))
        fi
        ;;
      "[B") # Down
        if [[ $selected -ge $((${#choices[@]} - 1)) ]]; then
          selected=0
        else
          selected=$((selected + 1))
        fi
        ;;
    esac
  elif [[ -z "$key" ]]; then
    # ENTER pressed
    break
  fi
done

selection="${choices[$selected]}"

case "$selection" in
  android)
    bash "${script_dir}/release_android.sh"
    ;;
  ios)
    echo "iOS release flow is not configured yet."
    exit 1
    ;;
  quit)
    echo "Aborted."
    exit 0
    ;;
esac


