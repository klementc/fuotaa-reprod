BEGIN {OFS = ","
#  print "timestamp,device,nb_ED,seed,objSize,distance,policy,start,end,dur"
}


# NS-3 logs
/Update finished, started/ {
  gsub(/^\+|s$/, "", $1)
  print $1,threshold,$2,nb_ED,seed,objSize,distance,policy,$7,$9,$9-$7
}
