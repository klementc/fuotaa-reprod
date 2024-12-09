
objSize=(2000)
CR=0
nbED=(100 150 200)
seeds=(1 2 3 4 5) # 11 12 13 14 15)
dist=(20000) # 16000 17000 18000 19000)
policy=("ALL" "FASTEST" "THRESHOLD2" "THRESHOLD3")
#threshold=(10000 16000)
delayReTx=240
EMIT_DELAY=1500
DUR_POOLING=1500
inter_FUOTA_interval=3600
simDur=604800 # one week

logdir="../logs_continuous/"

if [ ! -d ${logdir} ]; then
  mkdir ${logdir}
fi


echo "timestamp,threshold,device,nb_ED,seed,objSize,distance,policy,start,end,dur,roundNB" > ${logdir}/test_d.csv
echo "DR,timestamp,threshold,event,device,nb_ED,seed,objSize,distance,fport,policy" > ${logdir}/test.csv
echo "nb_ED,threshold,objSize,policy,seed,ts,device,energy"> ${logdir}/test_den.csv

set -x
for i in ${objSize[@]}; do
  for seed in ${seeds[@]}; do
    for j in ${nbED[@]}; do
      for pol in ${policy[@]}; do
          # run simulations
          logFile="${logdir}/logNS_${i}_${j}_${seed}_${pol}_${threshold}_continuous.log"
          ../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_scale_test-default --policy=${pol} --nb_ED=${j} --obj_size=${i} --seed=${seed} --delayReTx=${delayReTx} --CR=${CR} --duration=${simDur} --singleRound=0 --useRNG=1 --EMIT_DELAY=${EMIT_DELAY} --DUR_POOLING=${DUR_POOLING} --inter_FUOTA_interval=${inter_FUOTA_interval} > ${logFile} 2>&1


          if [[ $pol -eq "THRESHOLD2" ]]
          then
            thr=10000
          elif [[ $VAR -eq 10 ]]
          then
            thr=16000
          else
            thr=0
          fi

          awk -v threshold=${thr} -v nb_ED=${j} -v seed=${seed} -v objSize=${i} -v distance=0 -v policy=${pol} -f parse_timeonair_en.awk ${logFile}  >> ${logdir}/test_den.csv
          awk -v threshold=${thr} -v nb_ED=${j} -v seed=${seed} -v objSize=${i} -v distance=0 -v policy=${pol} -f parse_durFUOTA_nbround.awk ${logFile}  >> ${logdir}/test_d.csv
          awk -v threshold=${thr} -v nb_ED=${j} -v seed=${seed} -v objSize=${i} -v distance=0 -v policy=${pol} -f parse_events.awk ${logFile}  >> ${logdir}/test.csv
      done
    done
  done
done
