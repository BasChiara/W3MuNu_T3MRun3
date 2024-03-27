#! /bin/bash

# Define number of events & SEED
export NUMBEREVENTS=20000
export RANDOM_STATE=$(date '+%M') 
echo "> set-up GEN production with ${NUMBEREVENTS} events and seed ${RANDOM_STATE}"

# Define workdir
export WORKDIR=`pwd`

# Define gridpack location, warning if you are using crab, requires global accessible gridpack
# If running locally you can also set a local gridpack location
export GRIDPACKLOC=/afs/cern.ch/user/c/cbasile/public/ppW3MuNu_production/ppW3MuNu_smfull_el8_amd64_gcc10_CMSSW_12_4_8_tarball.tar.xz
echo "> use gridpack stored in ${GRIDPACKLOC}"

# Use crab for grid submitting, adjust crabconfig.py accordingly beforehand
export USECRAB="True"
export DRYRUN="True"

export STARTDIR=`pwd`
echo "> start dir was: $STARTDIR "

echo "> workdir set is: $WORKDIR"
mkdir -p $WORKDIR
echo "  ... created workdir"
cd $WORKDIR
echo "  ... changed into workdir"

echo "> copy run script to workdir"
TARBALL_PATH=GeneratorInterface/LHEInterface/data/
mkdir -p $TARBALL_PATH 
cp $CMSSW_RELEASE_BASE/src/$TARBALL_PATH/run_generic_tarball_cvmfs.sh GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh

echo " [+] set number of events in python config to ${NUMBEREVENTS}"
sed -e "s/#NUMBEREVENTS#/${NUMBEREVENTS}/g" $STARTDIR/ppW3MuNu_fragment_LHEGS_cfg_draft.py > ./ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py
echo " [+] set random state seed = ${RANDOM_STATE}"
sed -e "s/#RANDOM_STATE#/${RANDOM_STATE}/g" $STARTDIR/ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py
rm ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py

if [ $USECRAB = "True" ]; then
	echo "> CRAB submission: adjust crabconfig.py accordingly "
	echo " [+] set number of events in crabconfig_draft.py to ${NUMBEREVENTS}"
	sed -e "s/#NUMBEREVENTS#/${NUMBEREVENTS}/g" $STARTDIR/crabconfig_draft.py > ./crabconfig.py
   	echo " [+] copy gridpack for production to workdir, so that crab can transfer it also"
        cp $GRIDPACKLOC gridpack.tgz
	echo " [+] gridpack location to python config and copy cmssw python config to workdir"
	sed -e "s~#GRIDPACKLOCATION#~../gridpack.tgz~g" ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg.py
   	rm ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py

	echo "> load CRAB environments & proxy"
	source setup_crab.sh

   	echo "Scram b and start of LHEGEN production"
   	scram b -j 8
   	echo "----------------------------------------------------------------------"

   if [ $DRYRUN = "True" ]; then
    	echo "--> dryrun : config files created and NO jobs really submitted"
   else
    	echo "--> submitting CRAB jobs for real ..."
    	echo "----------------------------------------------------------------------"
    	python3 crabconfig.py
   fi

else
	echo "--> local production using cmsRun"

	echo "[+] copy gridpack for production to workdir"
	cp $GRIDPACKLOC gridpack.tgz

	echo "[+] add gridpack location to python config and copy cmssw python config to workdir"
	export GRIDPACKWORKDIR=`pwd`
	sed -e "s~#GRIDPACKLOCATION#~${GRIDPACKWORKDIR}/gridpack.tgz~g" ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg.py
   	rm ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py
	echo "> load proxy"	
	voms-proxy-init --voms cms --valid 168:00
	echo "Scram b and start of LHEGEN production"
	scram b -j 8
   	echo "----------------------------------------------------------------------"
	
	cmsRun ppW3MuNu_fragment_LHEGS_cfg.py

	echo "Finished local production using cmsRun"
fi
