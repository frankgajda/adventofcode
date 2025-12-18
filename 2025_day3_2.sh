#!/bin/bash
# I cannot claim this code as entierly my own, 
# I had to seek inspiraition from several sources 
# to crack this one - but I learned a lot along the way :-) 

get-max() {
  local bank="$1"
  local length=${#bank}
  local pos=12
  local bankarr=()
  local a 
  
  # create "bank array"
  for((a=0; a < length; a++)); do
    bankarr+=("${bank:${a}:1}")
  done
  get-number "${pos}" "${bankarr[@]}"
}

get-number() {
  local pos=$1
  shift 
  local bankarr=("$@")
  local length=${#bankarr[@]}
  local  b c 
  if((debug)); then
    echo "position="${pos} >&2 
    echo "bank length: "${length} >&2
    echo "rest: " ${bankarr[*]} >&2
  fi
  if (( ${pos} == 0 )); then 
    return 0  
  fi
  
  # try numbers from 9 down to 1 - in posistions
  for b in $(seq 9 -1 1); do
    
    for((c = 0; c <= length - ${pos}; c++)); do
    
      if (( ${bankarr[${c}]} == ${b} )); then 
        echo -n ${b} 
        echo "got ${b} at pos ${c}. Grab!" >&2
        new_pos=$((${c} +1 ))
        get-number "$(($pos - 1))" "${bankarr[@]:${new_pos}}"
        return 0 
      fi
    done
  done 
}   

total=0
debug=0
line=1
while read bank; do
  echo "-----" >&2
  echo "Bank: " $line >&2
  number=$(get-max "$bank")
  echo "Bank num: "${number} >&2
  (( total += number))
  ((line++))
done < data_day3
echo "Total Sum: "${total}
