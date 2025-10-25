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

# export fg0=${a[((i++))]}
# export fg1=${a[((i++))]}
# export fg2=${a[((i++))]}
# export fg3=${a[((i++))]}

# export bg0=${a[((i++))]}
# export bg1=${a[((i++))]}
# export bg2=${a[((i++))]}
# export bg3=${a[((i++))]}
# export bg4=${a[((i++))]}
# export bg5=${a[((i++))]}
# export bg6=${a[((i++))]}
# export bg7=${a[((i++))]}
# export bg8=${a[((i++))]}
# export bg9=${a[((i++))]}

fhex() {
  if [ -n "$1" ]
  then
    IN="$1"
  else
    read IN
  fi
  pastel format hex "$IN"
}

darken() {
  pastel darken 0.15 "$1"
}

lighten() {
  pastel lighten 0.15 "$1"
}

export dollar='$'

for f in ./templates/*.template; do
  echo "$f"
  t=$( envsubst <$f )
  p=$( echo "$t" | sed -n '1p' )
  readarray -t cs <<< $( echo "$t" | grep -o '$([^$]\+)' )
  # echo ${#cs[@]}
  for i in "${cs[@]}"; do
    if [ "$i" == "" ]; then
      continue
    fi
    cmd="$( echo "$i" | sed "s/\$(\(.\+\))/\1/" )"
    result="$( eval ${cmd} )"
    t="$( echo "$t" | sed "s/${i}/${result}/" )"
  done
  echo "$t" | sed -n '2~1p' > "$p"
done
