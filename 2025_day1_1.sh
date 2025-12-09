#!/bin/bash

# start at posistion 50
pointer=50
# init zero count
zero=0
# Debug?
debug=0

for i in `cat data_day1`
do
  # get direction left or right - first letter
  direction=${i:0:1}
  # get number of clicks - rest of string
  change=${i:1}
  # sanitize
  let change="$(( ${i:1}  % 100 ))"
  # debug
  if [ ${debug} -gt "0" ]
  then
    echo "Direction: " ${direction}
    echo "Change: " ${change}
  fi
  # do stuff
  if [ ${direction} == "L" ]
  then
    let pointer="(100 - ${change}) + ${pointer}"
  else
    let pointer="${change} + ${pointer}"
  fi
  if [ ${pointer} -gt 99 ]
  then
    if [ ${debug} -gt "0" ]
    then
      echo "Large pointer: " ${pointer}
    fi
      let pointer="$((${pointer} % 100 ))"
  fi

  if [ ${pointer} -eq 0 ]
  then
    let zero="${zero} + 1"
  fi
  if [ ${debug} -gt "0" ]
  then
  echo "Pointer: " ${pointer}
  echo "Zero count: " ${zero}
  fi
done
echo "Zero count: " ${zero}
