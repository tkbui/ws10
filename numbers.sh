#!/bin/bash

# this is a shell script that gets the min, max, and avg helpfulness values
# (column 9) of the amazon file.

# variables
file="amazon_reviews_us_Books_v1_02.tsv";

# PROCESS:
# 1) get only the helpfulness column from the amazon file
# 2) sort the column
# 3) now we iterate through each row of this single column --
#    since it's sorted, the first row is the min and the last row is the max.
#    we'll keep adding each row/value to a running sum and increment a counter
#    for each value we add to the sum, then use those numbers to get the avg.
awk -F "\t" 'NR > 1 {print $9}' $file | sort -n | awk '

 {if (NR==1) min=$1; }
 {if (NR==NR) max=$1;}
 {sum_values += $1; total_values++;}

 END {
  avg = sum_values / total_values;
  {printf "min %s max %s avg %.14f\n", min, max, avg}
 }
'
