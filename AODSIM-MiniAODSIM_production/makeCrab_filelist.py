import os
import glob

AODsim_dir = '/eos/cms/store/group/phys_bphys/cbasile/ppW3MuNu_Run3Summer22EE_pMC_2024Mar28/ppW3MuNu_MGv5NLO_pythia8_LHEGS/ppW3MuNu_mc_Run3Summer22EE_GENSimAODSim/240327_233734/0000/*.root'
file_list  = glob.glob(AODsim_dir)
formatted_files = [f.replace('/eos/cms', '', 1) for f in file_list]
input_to_crab = 'filelist_crab.txt'
with open(input_to_crab, 'w') as file:
    [file.write('%s\n'%f) for f in formatted_files]

#print(formatted_files)
#draft_file = 'ppW3MuNu_Run3Summer22EEDRPremix_cfg_draft.py' 
#final_file = 'ppW3MuNu_Run3Summer22EEDRPremix_cfg.py' 

#with open(input_to_crab, 'r') as file:
#    file_contents = file.read()
#    updated_contents = file_contents.replace(string_to_replace, formatted_files)
#
#    with open(final_file, 'w') as file:
#        file.write(updated_contents)
