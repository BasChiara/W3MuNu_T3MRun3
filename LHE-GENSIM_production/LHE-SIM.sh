#! /bin/bash

# step LHE -> GEN-SIM
# setting taken from Run3Summer22EE campaign : 
#     > https://cms-pdmv-prod.web.cern.ch/mcm/requests?dataset_name=WtoTauNu_Tauto3Mu_TuneCP5_13p6TeV_pythia8&page=0&shown=127
# Random seed between 1 and 100
CUSTOM="\
process.RandomNumberGeneratorService=cms.Service('RandomNumberGeneratorService',\
  generator=cms.PSet(initialSeed=cms.untracked.uint32(${SEED})),\
  VtxSmeared=cms.PSet(initialSeed=cms.untracked.uint32(${SEED}))\
)"
EVENTS=12
SEED=22

cmsDriver.py Configuration/GenProduction/python/ppW3MuNu_fragment.py  \
  --python_filename ppW3MuNu_fragment_LHEGS_cfg_draft.py             \
  --mc                                                                \
  --eventcontent RAWSIM                                               \
  --datatier GEN-SIM                                                  \
  --conditions 124X_mcRun3_2022_realistic_postEE_v1                   \
  --beamspot Realistic25ns13p6TeVEarly2022Collision                   \
  --step LHE,GEN,SIM                                                  \
  --geometry DB:Extended                                              \
  --era Run3                                                          \
  --fileout file:ppW3MuNu_Run3Summer22EEwmLHEGS.root                  \
  --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})"\
  --no_exec                                                           \
  -n $EVENTS;  
