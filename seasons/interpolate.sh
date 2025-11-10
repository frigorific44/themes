#!/bin/bash

# If no arguments, exit.
if [[ $# -ne 3 ]]; then
    echo "${0} <theme1> <theme2> <mix-fraction>"
    exit
fi

theme1=$1
theme2=$2
mix_f=$3
if [ ! -f $theme1 ] || [ ! -f $theme2 ]; then
  echo "Files not found."
  exit
fi
readarray -t palette1 <<< $(grep "^[^#*/;]" $theme1)
readarray -t palette2 <<< $(grep "^[^#*/;]" $theme2)
palette_size=${#palette1[@]}
for ((i = 0; i < palette_size; i++)); do
  components1=( $(echo "${palette1[i]}" | sed 's/oklch//gI;s/(//g;s/)//g;s/,//g') )
  components2=( $(echo "${palette2[i]}" | sed 's/oklch//gI;s/(//g;s/)//g;s/,//g') )
  components_length=${#components1[@]}
  declare -a new_components
  new_components[0]=$(echo "scale=4;( ${components1[0]} * (1 - ${mix_f})) + ( ${components2[0]} * ${mix_f})" | bc )
  new_components[1]=$(echo "scale=4;( ${components1[1]} * (1 - ${mix_f})) + ( ${components2[1]} * ${mix_f})" | bc )
  new_components[2]=$(echo "scale=4;( ${components1[2]} * (1 - ${mix_f})) + ( ${components2[2]} * ${mix_f})" | bc )
  shortest_angle=$(echo "( (${components2[2]} - ${components1[2]}) + 180 ) % 360 - 180" | bc)
  new_components[2]=$(echo "(${components1[2]} + (${mix_f} * ${shortest_angle})) % 360" | bc)
  oklch_mix=$(echo "OkLCh(${new_components[0]}, ${new_components[1]}, ${new_components[2]})" | pastel format oklch)
  lch_mix=$(pastel mix -s lch -f "$mix_f" "${palette2[i]}" "${palette1[i]}" | pastel format oklch)
  lab_mix=$(pastel mix -s lab -f "$mix_f" "${palette2[i]}" "${palette1[i]}" | pastel format oklch)
  # echo "$oklch_mix"
  # echo "$lch_mix"
  # echo "$lab_mix"
  pastel mix -s lab -f 0.5 "${oklch_mix}" "${lch_mix}" | pastel format oklch
done
