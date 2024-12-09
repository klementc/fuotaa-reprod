BEGIN {OFS = ","
#print "DR,timestamp,threshold,event,device,nb_ED,seed,objSize,distance,fport,policy"
}


# NS-3 logs
/Finished Tx,/ {
  gsub(/^\+|s$/, "", $1)
  if ($9=="true") {
    event="TX"
    # dont print becausethere will be an ack
    # UPDATE: print to see all events uplink or downlink
    print dr,$1,threshold,event,$7,nb_ED,seed,objSize,distance,$18,policy
  }
  else {
    event="TX"
	  print dr,$1,threshold,event,$7,nb_ED,seed,objSize,distance,$18,policy
  }
}

/Received ACK on/ {
  gsub(/^\+|s$/, "", $1)
  event="RX"
	print dr,$1,threshold,event,$7,nb_ED,seed,objSize,distance,$13,policy
}
