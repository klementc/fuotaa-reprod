#!/bin/bash

# Set your variables
size="8 16 32 64"      # Replace with your actual size value
device="1 2 3 4"  # Replace with your actual device value

# Directory containing CSV files
input_dir="../"  # Replace with the actual directory path
output_file="combined_logs.csv"


for s in ${size[@]}; do
  for d in ${device[@]}; do
    awk -v size="$s" -v device="$d" -f parse_execDur.awk ../log_${d}_${s}.log >> "$output_file"
  done
done