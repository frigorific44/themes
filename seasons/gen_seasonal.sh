#!/bin/bash

DIR="$( dirname -- "${BASH_SOURCE[0]}" )"
cp "${DIR}/3-Autumn.theme" "${DIR}/../themes/seasonal.theme"
${DIR}/../run.sh "${DIR}/../themes/seasonal.theme"
