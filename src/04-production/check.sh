#!/bin/bash
# Check equilibration MD simulation results

STRUC_DIR="data/00-structure"
MIN_DIR="data/01-minimisation"
HEAT_DIR="data/02-heating"
EQ_DIR="data/03-equilibration"
PROD_DIR="data/04-production"
TMP_DIR="tmp"

ambpdb -p ${STRUC_DIR}/complex.prmtop -c ${STRUC_DIR}/complex.inpcrd > ${TMP_DIR}/complex.pdb
ambpdb -p ${STRUC_DIR}/complex.prmtop -c ${MIN_DIR}/01.min_solv.ncrst > ${TMP_DIR}/01.min_solv.pdb
ambpdb -p ${STRUC_DIR}/complex.prmtop -c ${MIN_DIR}/02.min_solu.ncrst > ${TMP_DIR}/02.min_solu.pdb
ambpdb -p ${STRUC_DIR}/complex.prmtop -c ${HEAT_DIR}/heat.ncrst > ${TMP_DIR}/heat.pdb
ambpdb -p ${STRUC_DIR}/complex.prmtop -c ${EQ_DIR}/eq.ncrst > ${TMP_DIR}/eq.pdb

process_mdout.perl ${HEAT_DIR}/heat.out ${EQ_DIR}/eq.out ${PROD_DIR}/prod.*.out
mv summary* -t ${TMP_DIR}
