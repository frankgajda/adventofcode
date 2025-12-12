#!/bin/bash
count=0

# split comma sparated data from file into an array
while IFS=',' read -r -a array; do
  echo "Data: " ${array[@]}

  # load span limits into array
  for span in ${array[@]}; do
    span=(${span//-/ })

    # check every ID in the range
    for num in $(seq ${span[0]} ${span[1]}); do
      
      # if ID is an odd number, skip
      if [ $((${#num} % 2)) -ne 0 ]; then
        continue
      else
        # ID is even - so split the number at half lenght
        let split=(${#num} / 2)
        first=${num:0:$split}
        last=${num:$split}

        # check if first half and last half match - if so, add ID to total sum
        if [ ${first} -eq ${last} ]; then
          let count="${num} + ${count}"
        fi
      fi
    done
  done
done < data_day2

# Show total sum of IDs
echo "Total: " ${count}

