BEGIN{
# print "addr,event,start,end,freq,size,DR,sample"
}

/DevEUI:      / {
  sub("\r$", "")
  addr=$3
}

/MAC Tx start packet/ {
  sub("\r$", "")
  size=$6
  #print $6
}

/TX on freq/ {
  sub("\r$", "")
  gsub( "[:':']"," " )
  gsub( "[:'s']","." )
  freq=$5
  DR=$9
  tstart=$1
}

/MAC txDone/ {
  sub("\r$", "")
  gsub( "[:':']"," " )
  gsub( "[:'s']","." )

  tend=$1

  print  addr ",TX," tstart "," tend "," freq "," size "," DR "," sample
}

/RX_C on freq/ {
  sub("\r$", "")
  gsub( "[:':']"," " )
  gsub( "[:'s']","." )
  freq=$5
  DR=$9
  tstart=$1
}

/MAC rxDone/ {
  sub("\r$", "")
  gsub( "[:':']"," " )
  gsub( "[:'s']","." )

  tend=$1
  size=0

  print  addr ",RX," tstart "," tend "," freq "," size "," DR "," sample
}
