#!/bin/bash

theme=$1
if [ ! -f $theme ]; then
  echo "File not found."
  exit
fi
tn=${theme##*/}
tn=${tn%.*}
export theme_name="my-${tn}"
readarray -t a <<< $(grep "^[^#*/;]" $theme | pastel format rgb | sed "s/rgb(//g;s/)//g;s/ //g")
i=0
export red_d=${a[((i++))]}
export red=${a[((i++))]}
export red_l=${a[((i++))]}

export orange_d=${a[((i++))]}
export orange=${a[((i++))]}
export orange_l=${a[((i++))]}

export yellow_d=${a[((i++))]}
export yellow=${a[((i++))]}
export yellow_l=${a[((i++))]}

export green_d=${a[((i++))]}
export green=${a[((i++))]}
export green_l=${a[((i++))]}

export aqua_d=${a[((i++))]}
export aqua=${a[((i++))]}
export aqua_l=${a[((i++))]}

export blue_d=${a[((i++))]}
export blue=${a[((i++))]}
export blue_l=${a[((i++))]}

export purple_d=${a[((i++))]}
export purple=${a[((i++))]}
export purple_l=${a[((i++))]}

export fg0=${a[((i++))]}
export fg1=${a[((i++))]}
export fg2=${a[((i++))]}
export fg3=${a[((i++))]}

export bg0=${a[((i++))]}
export bg1=${a[((i++))]}
export bg2=${a[((i++))]}
export bg3=${a[((i++))]}
export bg4=${a[((i++))]}
export bg5=${a[((i++))]}
export bg6=${a[((i++))]}
export bg7=${a[((i++))]}
export bg8=${a[((i++))]}
export bg9=${a[((i++))]}

for f in ./templates/*.template; do
  echo "$f"
  t=$( envsubst <$f )
  p=$( echo "$t" | sed -n '1p' )
  readarray -t cs <<< $( echo "$t" | grep -o "\$([^)]\+)" )
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
