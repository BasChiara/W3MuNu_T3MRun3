import os
import glob

GENsim_dir = '/eos/cms/store/group/phys_bphys/cbasile/ppW3MuNu_Run3Summer22EE_privateMC_LHEGS_v2_2024Apr02/ppW3MuNu_Run3Summer22EE_mc_MGv5NLO_pythia8_v2/ppW3MuNu_Run3Summer22EE_mc_LHEGS_v2/240402_131603/0000/*.root'
file_list  = glob.glob(GENsim_dir)
formatted_files = [f.replace('/eos/cms', '', 1) for f in file_list]
input_to_crab = 'filelist_crab.txt'
with open(input_to_crab, 'w') as file:
    [file.write('%s\n'%f) for f in formatted_files]