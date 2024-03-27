import os
import glob

gensim_dir ='/eos/cms/store/group/phys_bphys/cbasile/ppW3MuNu_Run3Summer22EE_pMC_2024Mar15/ppW3MuNu_MGv5NLO_pythia8_LHEGS/ppW3MuNumc_evLHEGS/240315_175153/0000/*.root'
file_list  =glob.glob(gensim_dir)
string_to_replace = 'FILES_IN'
formatted_files = "','".join(file_list) 
#print(formatted_files)
draft_file = 'ppW3MuNu_Run3Summer22EEDRPremix_cfg_draft.py' 
final_file = 'ppW3MuNu_Run3Summer22EEDRPremix_cfg.py' 
with open(draft_file, 'r') as file:
    file_contents = file.read()
    updated_contents = file_contents.replace(string_to_replace, formatted_files)

    with open(final_file, 'w') as file:
        file.write(updated_contents)
