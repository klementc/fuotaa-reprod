#!/bin/bash

# Set your variables
size="$1"      # Replace with your actual size value
device="$2"  # Replace with your actual device value

# Directory containing CSV files
input_dir="PM_${device}_${size}_record/"  # Replace with the actual directory path
output_file="combined_output.csv"

# Create or clear the output file
>> "$output_file"

# Process each CSV file in the directory
for file in "$input_dir"/*_summary.csv; do
    if [[ -s $file ]]; then
        awk -v size="$size" -v device="$device" '
            BEGIN { FS=";"; OFS="," }
           {
                # Append size and device values to each record line
                gsub(";", ",", $0)
                print size,device,$0

            }
        ' "$file" >> "$output_file"
    fi
done
