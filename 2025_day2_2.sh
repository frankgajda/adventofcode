#!/bin/bash
debug=0
sum=0

# split comma separated data from file into an array
while IFS=',' read -r -a array; do

  if ((debug)); then
    echo "Data: " ${array[@]}
  fi

  # load range limits into array
  for span in ${array[@]}; do

    # split by hyphen
    span=(${span//-/ })

    # check each ID in the range
    for num in $(seq ${span[0]} ${span[1]}); do

      lenght=${#num}

      # we are looking for a repeated pattern, so we only need 
      # to check to half lenght of string
      split=$(( ${lenght} / 2 ))
      
      if ((debug)); then
      echo "---------" 
      echo "Num: "${num} 
      echo "Lenght: "${lenght}
      echo "Split: "${split}
      fi 

      ## chop up the number in chunks - from 1 to half lenght
      for ((i = 1; i <= ${split}; i++)); do

        # first chunk to check
        part=${num:0:${i}}

        if ((debug)); then
          echo "i: " ${i}
          echo "Part: "${part}
        fi

        # if the lenght is divisible with the size of the chunk - check chunk!
        if [ $(($lenght % ${i})) == 0 ]; then

          string=""
 
          # find out the times we need to repeat the chunk to re-construct
          # the length of the number 
          repeat=$((${lenght} / ${i}))

          if ((debug)); then
            echo "Repeats: "${repeat}
	  fi

          # add pieces togther to construct the number and 
          for ((r = 0; r < repeat; r++)); do

              string+=${part}

          done

        fi
        
        # If our constructed string is the same as the initial  
        # number, display it and add to sum 
        if [[ ${string} == ${num} ]]; then
          echo "In-Valid ID: "${string}
          ((sum += ${num}))
          break
        fi

      done
    done
  done
done < data_day2

# Show total sum of IDs
echo "Total Sum: " ${sum}

