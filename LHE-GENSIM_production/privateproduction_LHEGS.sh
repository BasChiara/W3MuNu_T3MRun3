#! /bin/bash

# Define number of events
export NUMBEREVENTS=10000
export RANDOM_STATE=$(date '+%M') 
echo "Set-up GEN production with ${NUMBEREVENTS} and seed ${RANDOM_STATE}"

# Define workdir
export WORKDIR=`pwd`

# Define gridpack location, warning if you are using crab, requires global accessible gridpack
# If running locally you can also set a local gridpack location
export GRIDPACKLOC=/eos/user/c/cbasile/Tau3MuRun3/W3MuNu_SM_production/genproductions/bin/MadGraph5_aMCatNLO/ppW3MuNu_smfull_el8_amd64_gcc10_CMSSW_12_4_8_tarball.tar.xz

# Use crab for grid submitting, adjust crabconfig.py accordingly beforehand
export USECRAB="True"
export DRYRUN="False"

export STARTDIR=`pwd`
echo "Start dir was: $STARTDIR "

echo "Workdir set is: $WORKDIR"
mkdir -p $WORKDIR
echo "Created workdir"
cd $WORKDIR
echo "Changed into workdir"

echo "Copy run script to workdir"
TARBALL_PATH=GeneratorInterface/LHEInterface/data/
mkdir -p $TARBALL_PATH 
cp $CMSSW_RELEASE_BASE/src/$TARBALL_PATH/run_generic_tarball_cvmfs.sh GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh

echo " > set number of events in python config to ${NUMBEREVENTS}"
sed -e "s/#NUMBEREVENTS#/${NUMBEREVENTS}/g" $STARTDIR/ppW3MuNu_fragment_LHEGS_cfg_draft.py > ./ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py
echo " > set random state seed = ${RANDOM_STATE}"
sed -e "s/#RANDOM_STATE#/${RANDOM_STATE}/g" $STARTDIR/ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py
rm ppW3MuNu_fragment_LHEGS_cfg_eventsInserted.py

if [ $USECRAB = "True" ]; then
	echo "> CRAB submission, adjust crabconfig.py accordingly if problems arise"
	echo ">   change number of events in crab config to ${NUMBEREVENTS}"
	sed -e "s/#NUMBEREVENTS#/${NUMBEREVENTS}/g" $STARTDIR/crabconfig_draft.py > ./crabconfig.py
   echo ">   copy gridpack for production to workdir, so that crab can transfer it also"
        cp $GRIDPACKLOC gridpack.tgz
	echo "Add gridpack location to python config and copy cmssw python config to workdir"
	sed -e "s~#GRIDPACKLOCATION#~../gridpack.tgz~g" ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg.py
   rm ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py

	echo "Load crab environment, grid environment should be loaded manually in advance if necessary"
	source /cvmfs/cms.cern.ch/crab3/crab.sh

   echo "Scram b and start of LHEGEN production"
   scram b -j 8

   if [ $DRYRUN = "True" ]; then
      echo "Config files created and NO jobs really submitted"
   else
      echo "Submitting CRAB jobs for real ..."
      echo "----------------------------------------------------------------------"
      python3 crabconfig.py
   fi

else
	echo "Local production using cmsRun"

	echo "Copy gridpack for production to workdir"
	cp $GRIDPACKLOC gridpack.tgz

	echo "Add gridpack location to python config and copy cmssw python config to workdir"
	export GRIDPACKWORKDIR=`pwd`
	sed -e "s~#GRIDPACKLOC#~${GRIDPACKWORKDIR}/gridpack.tgz~g" ./ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py > ./ppW3MuNu_fragment_LHEGS_cfg.py
   rm ppW3MuNu_fragment_LHEGS_cfg_seedInserted.py

	echo "Scram b and start of LHEGEN production"
	scram b -j 8
   echo "----------------------------------------------------------------------"

	cmsRun ppW3MuNu_fragment_LHEGS_cfg.py

	echo "Finished local production using cmsRun"
fi
