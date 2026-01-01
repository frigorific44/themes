#!/bin/bash

initial_wd=`pwd`
cd "$( dirname -- "${BASH_SOURCE[0]}" )"
filename() {
  path="$1"
  fname="${path##*/}"
  fname="${fname%.*}"
  echo $fname
}

epoch_seconds() {
  echo $(date --date="${1}" +"%s")
}

year_curr=$(date +"%Y")
sec_curr=$(date +"%s")

seasons=(./*.theme)

start_diff=-99999999
end_diff=99999999
for theme in "${seasons[@]}"; do
  for ((year = year_curr - 1; year <= year_curr + 1; year++ )); do
    theme_date=$(filename "${theme}")
    sec_theme=$(epoch_seconds "${year}-${theme_date}")
    theme_diff=$(( sec_theme - sec_curr ))
    if [[ $theme_diff -lt 0 ]]; then
      if [[ $theme_diff -gt $start_diff ]]; then
        start_diff="$theme_diff"
        start_theme="$theme"
        start_year="$year"
        start_sec="$sec_theme"
      fi
    else
      if [[ $theme_diff -lt $end_diff ]]; then
        end_diff="$theme_diff"
        end_theme="$theme"
        end_year="$year"
        end_sec="$sec_theme"
      fi
    fi
  done
done

echo $start_year
echo $start_theme
echo $end_year
echo $end_theme

proportion=$(echo "scale=4;($sec_curr - $start_sec) / ($end_sec - $start_sec)" | bc)
echo $proportion

./interpolate.sh "$start_theme" "$end_theme" "$proportion" > ../themes/seasonal.theme
./../run.sh "./themes/seasonal.theme"

cd "$initial_wd"
