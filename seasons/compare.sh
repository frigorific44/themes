#!/bin/bash

theme=$1
if [ ! -f $theme ]; then
  echo "File not found."
  exit
fi

swatch_str="███abc"
# tn=${theme##*/}
# tn=${tn%.*}
# export theme_name="my-${tn}"
readarray -t palette1 <<< $(grep "^[^#*/;]" $theme)

for color in "${palette1[@]}"; do
  pastel paint -n -o "${palette1[0]}" "$color" "$swatch_str"
  echo
done
