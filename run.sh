#!/bin/bash

theme=$1
if [ ! -f $theme ]; then
  echo "File not found."
  exit
fi
tn=${theme##*/}
tn=${tn%.*}
export theme_name="my-${tn}"
readarray -t a <<< $(grep "^[^#*/;]" $theme | pastel format OKLch)
i=0
export bg=${a[((i++))]}
export accent=${a[((i++))]}
export fg=${a[((i++))]}

export red=${a[((i++))]}
export yellow=${a[((i++))]}
export green=${a[((i++))]}
export cyan=${a[((i++))]}
export blue=${a[((i++))]}
export magenta=${a[((i++))]}

fhex() {
  if [ -n "$1" ]
  then
    IN="$1"
  else
    read IN
  fi
  pastel format hex "$IN"
}

# Lightness adjustment in the OKLch/OKLab color space.
l_step="0.04"
l-adj() {
  amount="$1"
  if [ -n "$2" ]
  then
    color="$2"
  else
    read color
  fi
  l="$(pastel format oklch-lightness "$color")"
  c="$(pastel format oklch-chroma "$color")"
  h="$(pastel format oklch-hue "$color")"
  calc="$l + ( $amount * $l_step )"
  l="$(echo "$calc" | bc)"
  echo "OkLCh(${l}, ${c}, ${h})"
}

export dollar='$'

for f in ./templates/*.template; do
  echo "$f"
  t=$( envsubst <$f )
  p=$( echo "$t" | sed -n '1p' )
  readarray -t cs <<< $( echo "$t" | grep -o '%([^%]\+)%' )
  # echo ${#cs[@]}
  for i in "${cs[@]}"; do
    if [ "$i" == "" ]; then
      continue
    fi
    # echo "$i"
    cmd="${i:2:-2}"
    # echo "$cmd"
    result="$( eval ${cmd} )"
    # echo "$result"
    t="$( echo "$t" | sed "s/${i}/${result}/" )"
    # echo
  done
  echo "$t" | sed -n '2~1p' > "$p"
done
