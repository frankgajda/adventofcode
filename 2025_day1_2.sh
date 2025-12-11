#!/bin/bash

# start at posistion 50
dial=50
# init zero count
zeroes=0

# Debug?
debug=0

# do stuff:
for i in `cat data_day1`
do

  # get direction left or right - first letter L or R
  dir=${i:0:1}

  # get number of clicks - rest of string
  clicks=${i:1}

  # debug
  if [ ${debug} -gt 0 ]
  then
  echo "Direction: " ${dir}
  echo "Clicks: " ${clicks}
  fi

  # now, spin the bloody wheel!
  for ((a = 0; a < $clicks; ++a))
  do
    if [ ${dir} == "L" ]
    then
      ((dial--))
    else
      ((dial++))
    fi
    if [ ${debug} -gt 0 ]
    then
      echo "Dial: " $((${dial} % 100))
    fi
    if [ $((${dial} % 100)) -eq 0 ]
    then
      ((zeroes++))
    fi
  done
done

# output total count of zeroes
echo "Zeroes: " ${zeroes}
