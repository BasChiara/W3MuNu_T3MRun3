import CRABClient
from CRABClient.UserUtilities import config, ClientException
import datetime

process_name    = 'ppW3MuNu'
campaign        = 'Run3Summer22EE'
step            = 'GENsimAODsim' # DIGI,DATAMIX,L1,DIGI2RAW,HLT:2022v14,RAW2DIGI,L1Reco,RECO,RECOSIM
production_tag  = datetime.date.today().strftime('%Y%b%d')
version         = 'v2'

request_name    = '_'.join([process_name, campaign, step, version, production_tag])
work_area       = '_'.join([process_name, campaign,'privateMC', step, version, production_tag]) 
dataset_tag     = '_'.join([process_name, campaign, 'mc', step, version])
dataset_name    = '_'.join([process_name, campaign, 'mc', 'MGv5NLO_pythia8', version])

config = config()

config.section_("General")
config.General.requestName = request_name 
config.General.workArea = work_area 
config.General.transferLogs = True 
config.General.transferOutputs =True 

config.section_("JobType")
#config.JobType.pluginName = 'PrivateMC'
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = 'ppW3MuNu_Run3Summer22EEDRPremix_cfg.py'
config.JobType.scriptExe = 'jobScript.sh'
config.JobType.disableAutomaticOutputCollection = True 
# handle outputs manually to save ntuples from last stage only
config.JobType.outputFiles = ['ppW3MuNu_Run3Summer22EEAODsim.root']
config.JobType.inputFiles  = ['jobScript.sh', 'ppW3MuNu_Run3Summer22EEDRPremix_cfg.py', 'ppW3MuNu_Run3Summer22EEAODsim_cfg.py']#, 'ppW3MuNu_Run3Summer22EEMiniAODsim_cfg.py']
config.JobType.maxMemoryMB = 4000 #2500

config.section_("Data")
#config.Data.unitsPerJob = 800
#config.Data.totalUnits = #NUMBEREVENTS#
config.Data.publication = True 
config.Data.outputDatasetTag = dataset_tag 
config.Data.ignoreLocality = True
## BPH store @ CERN 
config.Data.outLFNDirBase = '/store/group/phys_bphys/cbasile/%s' % (config.General.workArea)
## if local files 
#config.Data.userInputFiles = open('filelist_crab.txt').readlines()
#config.Data.splitting = 'FileBased'
#config.Data.outputPrimaryDataset = dataset_name 
#config.Data.unitsPerJob = 1
## if dataset public on DBS
config.Data.inputDBS = 'phys03'
config.Data.inputDataset = '/ppW3MuNu_Run3Summer22EE_mc_MGv5NLO_pythia8_v2/phys_bphys-ppW3MuNu_Run3Summer22EE_mc_LHEGS_v2-85cc5283084273354ab3c3d23b7237d8/USER'
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1

config.section_("Site")
config.Site.storageSite = 'T2_CH_CERN'
config.Site.whitelist = ['T2_CH_CERN']

config.section_("User")


if __name__ == '__main__':
    from CRABAPI.RawCommand import crabCommand
    from CRABClient.ClientExceptions import ClientException
    from http.client import HTTPException
    from multiprocessing import Process
    
    def submit(config):
      try:
          crabCommand('submit', config = config)
      except HTTPException as hte:
          print("Failed submitting task:",hte.headers)
      except ClientException as cle:
          print("Failed submitting task:",cle)

    print(config)
    submit(config)
