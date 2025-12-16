#!/bin/bash
# brute force by getting left number in first for loop -  
# checking the numbers to the right one by one, from left to right. 
# Then the next "left'est" number + test all number to the right of it

total=0
debug=0

# get data from file
while read cells; do
  maxsum=0
  max=0
  length=${#cells}
  
  # select 10's value - ("lenght -1" as we don't want the last number)
  for((a=0; a < length - 1; a++)); do

    left=${cells:${a}:1}

    # iterate through the numbers to the right - and test one by one
    for((b=((a + 1)); b < length; b++)); do
       
      right=${cells:${b}:1}
      
      # construct new number
      new=${left}${right}
     
      # is it bigger than what we already got - then overwrite old
      if((new > max)); then
        
        ((max=new))

      fi
    done
  done
  # add to total sum
  ((total+=max))
  echo "Subtotal: " ${total}
done < data_day3
echo "Total sum: "${total}      
