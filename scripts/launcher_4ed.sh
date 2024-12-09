
logdir="../logs_4ed/"

if [ ! -d ${logdir} ]; then
  mkdir ${logdir}
fi

echo "=== Run simulations ==="

../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_4nodes_test-default --policy="FASTEST"        --obj_size=2000 --seed=8 --CR=0 --delayReTx=60 --duration=15000 --singleRound=1 --useRNG=0                        > ${logdir}/ns_log_4ed_FASTEST.log 2>&1
../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_4nodes_test-default --policy="FUOTA_BASELINE" --obj_size=2000 --seed=8 --CR=0 --delayReTx=60 --duration=15000 --singleRound=1 --useRNG=0                        > ${logdir}/ns_log_4ed_BASELINE.log 2>&1
../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_4nodes_test-default --policy="ALL"            --obj_size=2000 --seed=8 --CR=0 --delayReTx=60 --duration=15000 --singleRound=1 --useRNG=0                        > ${logdir}/ns_log_4ed_ALL.log 2>&1
../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_4nodes_test-default --policy="THRESHOLD"      --obj_size=2000 --seed=8 --CR=0 --delayReTx=60 --duration=15000 --singleRound=1 --useRNG=0 --thresholdUpdate=1000 > ${logdir}/ns_log_4ed_THRESHOLD2.log 2>&1
../deps/ns-allinone-3.41/ns-3.41/build/src/lorawan/examples/ns3.41-fuota_4nodes_test-default --policy="THRESHOLD"      --obj_size=2000 --seed=8 --CR=0 --delayReTx=60 --duration=15000 --singleRound=1 --useRNG=0 --thresholdUpdate=2000 > ${logdir}/ns_log_4ed_THRESHOLD3.log 2>&1

echo "Simulations finished, parse results into ${logdir}/singleed_timeonair_ns_dur.csv"

echo "DR,timestamp,threshold,event,device,nb_ED,seed,objSize,distance,fport,policy" > ${logdir}/4ed_timeonair_ns.csv


awk -v threshold=2000 -v nb_ED=4 -v seed=1 -v objSize=2000 -v distance=0 -v dr=ALL -v policy=BASELINE -f parse_events.awk ${logdir}/ns_log_4ed_BASELINE.log >> ${logdir}/4ed_timeonair_ns.csv
awk -v threshold=2000 -v nb_ED=4 -v seed=1 -v objSize=2000 -v distance=0 -v dr=ALL -v policy=FASTEST -f parse_events.awk ${logdir}/ns_log_4ed_FASTEST.log >> ${logdir}/4ed_timeonair_ns.csv
awk -v threshold=2000 -v nb_ED=4 -v seed=1 -v objSize=2000 -v distance=0 -v dr=ALL -v policy=ALL -f parse_events.awk ${logdir}/ns_log_4ed_ALL.log >> ${logdir}/4ed_timeonair_ns.csv
awk -v threshold=2000 -v nb_ED=4 -v seed=1 -v objSize=2000 -v distance=0 -v dr=ALL -v policy=THRESHOLD2 -f parse_events.awk ${logdir}/ns_log_4ed_THRESHOLD2.log >> ${logdir}/4ed_timeonair_ns.csv
awk -v threshold=2000 -v nb_ED=4 -v seed=1 -v objSize=2000 -v distance=0 -v dr=ALL -v policy=THRESHOLD3 -f parse_events.awk ${logdir}/ns_log_4ed_THRESHOLD3.log >> ${logdir}/4ed_timeonair_ns.csv

# parse results from real experiments

echo "addr,event,start,end,freq,size,DR,sample" > ${logdir}/4ed_timeonair_real_thresh2.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh2_node1_processed.log >> ${logdir}/4ed_timeonair_real_thresh2.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh2_node2_processed.log >> ${logdir}/4ed_timeonair_real_thresh2.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh2_node3_processed.log >> ${logdir}/4ed_timeonair_real_thresh2.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh2_node4_processed.log >> ${logdir}/4ed_timeonair_real_thresh2.csv

echo "addr,event,start,end,freq,size,DR,sample" > ${logdir}/4ed_timeonair_real_best.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_best_node1_processed.log >> ${logdir}/4ed_timeonair_real_best.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_best_node2_processed.log >> ${logdir}/4ed_timeonair_real_best.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_best_node3_processed.log >> ${logdir}/4ed_timeonair_real_best.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_best_node4_processed.log >> ${logdir}/4ed_timeonair_real_best.csv

echo "addr,event,start,end,freq,size,DR,sample" > ${logdir}/4ed_timeonair_real_all.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_all_node1.log >> ${logdir}/4ed_timeonair_real_all.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_all_node2.log >> ${logdir}/4ed_timeonair_real_all.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_all_node3.log >> ${logdir}/4ed_timeonair_real_all.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_all_node4.log >> ${logdir}/4ed_timeonair_real_all.csv

echo "addr,event,start,end,freq,size,DR,sample" > ${logdir}/4ed_timeonair_real_naive.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_naive_node1.log >> ${logdir}/4ed_timeonair_real_naive.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_naive_node2.log >> ${logdir}/4ed_timeonair_real_naive.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_naive_node3.log >> ${logdir}/4ed_timeonair_real_naive.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_naive_node4.log >> ${logdir}/4ed_timeonair_real_naive.csv

echo "addr,event,start,end,freq,size,DR,sample" > ${logdir}/4ed_timeonair_real_thresh3.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh3_node1.log >> ${logdir}/4ed_timeonair_real_thresh3.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh3_node2.log >> ${logdir}/4ed_timeonair_real_thresh3.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh3_node3.log >> ${logdir}/4ed_timeonair_real_thresh3.csv
awk -f real_fuota_parser_dur.awk ${logdir}/log_thresh3_node4.log >> ${logdir}/4ed_timeonair_real_thresh3.csv