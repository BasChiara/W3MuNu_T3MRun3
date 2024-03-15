import CRABClient
from CRABClient.UserUtilities import config, ClientException
import yaml
import datetime
from fnmatch import fnmatch
from argparse import ArgumentParser

process_name = 'ppW3MuNu'
production_tag = datetime.date.today().strftime('%Y%b%d')
name = process_name + '_Run3Summer22EE_LHEGS_'+ production_tag 

config = config()

config.section_('General')
config.General.requestName = name
config.General.workArea = '_'.join([process_name, 'Run3Summer22EE','pMC', production_tag])
config.General.transferOutputs = True
config.General.transferLogs = True

config.section_('Data')
config.Data.publication = False
config.Data.outputPrimaryDataset = process_name + '_MGv5NLO_pythia8_LHEGS'
config.Data.outLFNDirBase = '/store/group/phys_bphys/cbasile/%s' % (config.General.workArea)
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = 500 
config.Data.totalUnits = 10000
config.Data.outputDatasetTag = process_name + 'mc_evLHEGS' 
# chiara: check on DAS the DBS (no need for gridpack)
#config.Data.inputDBS = 'global'
#config.Data.inputDBS = 'phys03'

config.section_('JobType')
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'ppW3MuNu_fragment_LHEGS_cfg.py'
config.JobType.inputFiles = ['GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh', 'gridpack.tgz']
config.JobType.disableAutomaticOutputCollection = False # automatic recognition of output files
#config.JobType.outputFiles = ['ppW3MuNu_Run3Summer22EEwmLHEGS.root']
#config.JobType.allowUndistributedCMSSW = True

config.section_('User')

config.section_('Site')
# chiara: un-comment to store at cern
config.Site.storageSite = 'T2_CH_CERN'
# chiara: un-comment to store at Rome
#config.Site.storageSite = 'T2_IT_Rome'

if __name__ == '__main__':
    from CRABAPI.RawCommand import crabCommand
    from CRABClient.ClientExceptions import ClientException
    #from httplib import HTTPException
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
