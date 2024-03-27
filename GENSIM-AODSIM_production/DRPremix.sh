cmsDriver.py  step1 \
 --mc                                                        \
 --python_filename ppW3MuNu_Run3Summer22EEDRPremix_cfg_draft.py    \
 --eventcontent PREMIXRAW                                    \
 --datatier GEN-SIM-RAW                                      \
 --conditions 124X_mcRun3_2022_realistic_postEE_v1           \
 --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2022v14                 \
 --procModifiers premix_stage2,siPixelQualityRawToDigi       \
 --geometry DB:Extended                                      \
 --datamix PreMix                                            \
 --era Run3                                                  \
 --no_exec                                                   \
 --filein FILES_IN                                           \
 --fileout file:DRPremixout.root                             \
 --customise Configuration/DataProcessing/Utils.addMonitoring\
 --pileup_input "dbs:/Neutrino_E-10_gun/Run3Summer21PrePremix-Summer22_124X_mcRun3_2022_realistic_v11-v2/PREMIX" \
 -n -1 

