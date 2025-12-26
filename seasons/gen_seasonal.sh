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

year=$(date +"%Y")
sec_curr=$(date +"%s")

seasons=(./*.theme)
start_theme="${seasons[-1]}"
start_year=$year

end_theme="${seasons[0]}"
end_year=$(( year + 1 ))
seasons_size="${#seasons[@]}"
for ((i = 0; i < seasons_size; i++)); do
  theme_date=$(filename "${seasons[i]}")
  sec_theme=$(epoch_seconds "${year}-${theme_date}")

  if [[ $sec_curr -lt $sec_theme ]]; then
    end_theme="${seasons[i]}"
    end_year=$year
    start_index=(i - 1)
    if [[ $start_index -lt 0 ]]; then
      start_theme="${seasons[(i - 1)]}"
      start_year=($year - 1)
    else
      start_theme="${seasons[(i - 1)]}"
      start_year=$year
    fi
    break 
  fi
done

start_date=$start_year-$(filename "$start_theme")
sec_start=$(epoch_seconds $start_date)
echo $start_theme
echo $start_date
echo $sec_start
end_date=$end_year-$(filename "$end_theme")
sec_end=$(epoch_seconds $end_date)
echo $end_theme
echo $end_date
echo $sec_end
echo
proportion=$(echo "scale=4;($sec_curr - $sec_start) / ($sec_end - $sec_start)" | bc)
echo $season_total
echo $season_curr
echo $proportion

./interpolate.sh "$start_theme" "$end_theme" "$proportion" > ../themes/seasonal.theme
./../run.sh "./themes/seasonal.theme"

cd "$initial_wd"
