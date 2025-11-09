#!/bin/bash

# If no arguments, exit.
if [[ $# -ne 3 ]]; then
    echo "${0} <theme1> <mix-fraction> <theme2>"
    exit
fi

theme1=$1
theme2=$2
if [ ! -f $theme1 ] || [ ! -f $theme2 ]; then
  echo "Files not found."
  exit
fi
readarray -t palette1 <<< $(grep "^[^#*/;]" $theme1)
readarray -t palette2 <<< $(grep "^[^#*/;]" $theme2)
len=${#palette1[@]}
for ((i = 0; i < len; i++)); do
  pastel mix -f "$3" "${palette2[i]}" "${palette1[i]}" | pastel format oklch
done
