#! /usr/bin/bash
export bg_3=32,30,30
export bg_2=36,34,34
export bg_1=41,39,38
export bg0=45,43,42
export bg1=57,53,51
export bg2=69,64,60
export bg3=81,75,69
export bg4=94,86,79
export bg5=107,97,88
export bg6=120,109,98
export fg1=251,241,199
export fg2=228,218,178
export fg3=205,196,158
export fg4=183,174,138
export redd=204,36,29
export oranged=214,93,14
export yellowd=215,153,33
export greend=152,151,26
export aquad=104,157,106
export blued=69,133,136
export purpled=177,98,134
export red=251,73,52
export orange=254,128,25
export yellow=251,188,61
export green=184,187,38
export aqua=142,192,124
export blue=131,165,152
export purple=211,134,155
export redl=252,111,95
export orangel=254,165,93
export yellowl=253,207,114
export greenl=214,217,69
export aqual=173,209,159
export bluel=172,195,186
export purplel=225,172,186
for f in *.template; do
    t=$(envsubst <$f | grep .*)
    p=$(echo "$t" | sed -n '1p')
    if [[ $f == *.hex.template ]]; then
        while read line ; do
            h=$(pastel color "$line" | pastel format hex)
            t=$(echo "$t" | sed "s/$line/$h/g")
        done <<< $(echo "$t" | grep -o "rgb(.*)" | uniq)
    fi
    echo "$t" | sed -n '2~1p' > "$p"
done
