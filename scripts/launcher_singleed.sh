logdir="../logs_singleed/"

if [ ! -d ${logdir} ]; then
  mkdir ${logdir}
fi

echo "=== Run simulations ==="

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=0 --fbu_plsize=39 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr0.log 2>&1

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=1 --fbu_plsize=39 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr1.log 2>&1

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=2 --fbu_plsize=39 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr2.log 2>&1

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=3 --fbu_plsize=110 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr3.log 2>&1

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=4 --fbu_plsize=219 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr4.log 2>&1

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-bulk_comm_app_multicast-default --nb_ED=1 --obj_size=2000 --dist=0 --seed=1 --CR=0 --delayReTx=30 --duration=3600 --policy="FIXED_BY_USER" --position="Fixed" --fbu_freq=869.525 --fbu_dr=5 --fbu_plsize=230 --singleRound=1 --useRNG=0 > ${logdir}/ns_dr5.log 2>&1

echo "Simulations finished, parse results into ${logdir}/singleed_timeonair_ns_dur.csv"

echo "DR,timestamp,threshold,event,device,nb_ED,seed,objSize,distance,fport,policy" > ${logdir}/singleed_timeonair_ns_dur.csv

awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=0 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr0.log >> ${logdir}/singleed_timeonair_ns_dur.csv
awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=1 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr1.log >> ${logdir}/singleed_timeonair_ns_dur.csv
awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=2 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr2.log >> ${logdir}/singleed_timeonair_ns_dur.csv
awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=3 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr3.log >> ${logdir}/singleed_timeonair_ns_dur.csv
awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=4 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr4.log >> ${logdir}/singleed_timeonair_ns_dur.csv
awk -v nb_ED=1 -v seed=1 -v objSize=2000 -v distance=0 -v dr=5 -v policy=FIXED_BY_USER -f ./parse_events.awk ../logs_singleed/ns_dr5.log >> ${logdir}/singleed_timeonair_ns_dur.csv
