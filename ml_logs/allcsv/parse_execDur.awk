BEGIN { FS=" "; OFS="," }

/Prediction/ {
    print size,device,$2,$4
}