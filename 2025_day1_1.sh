#!/bin/bash
# adventofcode day1 task 1 

# start at posistion 50
pointer=50
# init zero count
zero=0
# Debug?
debug=0

while read i 
do
  # get direction left or right - first letter
  direction=${i:0:1}

  # get number of clicks - rest of string
  clickse=${i:1}

  # simplify - lets get rid of "hundreds"
  let clicks="$(( ${i:1}  % 100 ))"

  # debug
  if [ ${debug} -gt "0" ]
  then
    echo "Direction: " ${direction}
    echo "Change: " ${clicks}
  fi

  # do stuff
  # if CCW, add 100 to pointer position and subtract rotation (clicks)
  if [ ${direction} == "L" ]
  then
    let pointer=$(((100 + ${pointer}) - ${clicks}))
  # if CW just add rotation to pointer position
  else
    let pointer="${clicks} + ${pointer}"
  fi
  
  # strip the "hundreds" - we don't want them!
  if [ ${pointer} -gt 99 ]
  then
    if [ ${debug} -gt "0" ]
    then
      echo "Large pointer: " ${pointer}
    fi
      let pointer="$((${pointer} % 100 ))"
  fi

  # count zeroes
  if [ ${pointer} -eq 0 ]
  then
    ((zero++))
  fi
  
  # debug
  if [ ${debug} -gt "0" ]
  then
  echo "Pointer: " ${pointer}
  echo "Zero count: " ${zero}
  fi
done < data_day1

# output total number of zeroes
echo "Zero count: " ${zero}
