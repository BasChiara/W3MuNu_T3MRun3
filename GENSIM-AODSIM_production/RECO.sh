cmsDriver.py                                                \
 --mc                                                       \
 --python_filename ppW3MuNu_Run3Summer22EEAODsim_cfg.py     \
 --eventcontent AODSIM                                      \
 --datatier AODSIM                                          \
 --customise Configuration/DataProcessing/Utils.addMonitoring \
 --conditions 124X_mcRun3_2022_realistic_postEE_v1          \
 --step RAW2DIGI,L1Reco,RECO,RECOSIM                        \
 --procModifiers siPixelQualityRawToDigi                    \
 --geometry DB:Extended                                     \
 --filein file:DRPremixout.root                             \
 --fileout file:ppW3MuNu_Run3Summer22EEAODSIM.root          \
 --era Run3                                                 \
 --no_exec                                                  \
 -n -1 
