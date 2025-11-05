#!/bin/bash

swatch_str="███abc"
swatch() {
  for color in "$@"; do
    pastel paint -n -o "${1}" "$color" "$swatch_str"
    echo
  done
}

# If no arguments, exit.
if [[ $# -lt 1 ]]; then
    echo "Requires at least one theme path."
    exit
fi

# Only one theme.
if [[ $# -eq 1 ]]; then
  theme=$1
  if [ ! -f $theme ]; then
    echo "File not found."
    exit
  fi
  readarray -t palette <<< $(grep "^[^#*/;]" $theme)
  swatch "${palette[@]}"
fi

if [[ $# -eq 2 ]]; then
  theme1=$1
  theme2=$2
  if [ ! -f $theme ]; then
    echo "File not found."
    exit
  fi
  readarray -t palette1 <<< $(grep "^[^#*/;]" $theme1)
  readarray -t palette2 <<< $(grep "^[^#*/;]" $theme2)
  swatch "${palette1[@]}"
  swatch "${palette2[@]}"
fi
