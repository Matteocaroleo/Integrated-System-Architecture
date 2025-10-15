LOG_PATH="./log"
NETLIST_GEN_NAME="powerEstFirFilter"
BACK_ANNOT_NAME_1="backAnnotation_1"
BACK_ANNOT_NAME_2="backAnnotation_2"
VCD_PATH="./vcd"
TOP_ENTITY="datapath"
SAIF_PATH="./saif"

echo "this script computes the whole backannotation"

echo "running $NETLIST_GEN_NAME ..."
cd ./syn/
dc_shell -f ${NETLIST_GEN_NAME}.scr > $LOG_PATH/${NETLIST_GEN_NAME}.log

echo "running $BACK_ANNOT_NAME_1 ..."

# moving to correct directory
cd ./sim/
vsim -c -do ${BACK_ANNOT_NAME_1}.do > $LOG_PATH/${BACK_ANNOT_NAME_1}.log

echo "converting vcd2saif..."
 
vcd2saif -input $VCD_PATH/${TOP_ENTITY}_syn.vcd -output $SAIF_PATH/${TOP_ENTITY}_syn.saif > $LOG_PATH/vcd2saif.log

echo "running $BACK_ANNOT_NAME_2 ..."

cd ./syn/
dc_shell -f ${BACK_ANNOT_NAME_2}.scr > $LOG_PATH/${BACK_ANNOT_NAME_2}.log

echo "done"

exit 0

 
