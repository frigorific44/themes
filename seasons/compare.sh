#!/bin/bash

swatch() {
  for color in "$@"; do
    pastel paint -n -o "${1}" "$color" "███"
  done
  for color in "$@"; do
    pastel paint -n -o "${1}" "$color" "abc"
  done
  echo
}

# If no arguments, exit.
if [[ $# -lt 1 ]]; then
    echo "${0} <theme1>"
    echo "Outputs a single theme's color swatch."
    echo
    echo "${0} <theme1> <theme2>"
    echo "Outputs a series of color swatches, interpolating between the two themes."
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
# Two themes.
if [[ $# -eq 2 ]]; then
  theme1=$1
  theme2=$2
  if [ ! -f $theme ]; then
    echo "File not found."
    exit
  fi
  for i in {0..8}; do
    mix=$(echo "scale=2; $i / 8" | bc -l)
    readarray -t palette <<< $(./interpolate.sh "$theme1" "$theme2" "$mix")
    swatch "${palette[@]}"
  done
fi
