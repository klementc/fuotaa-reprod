BEGIN {OFS = ","
#print "nb_ED,objSize,policy,seed,ts,device,energy"
}


/Total energy/ {
  gsub(/^\+|s$/, "", $1)
	print nb_ED,threshold,objSize,policy,seed,$1,$2,$6
}
