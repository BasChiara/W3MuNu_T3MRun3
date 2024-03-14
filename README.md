# W3MuNu_T3MRun3
Code to produce private MC sample of W -> 3mu nu (SM) for Tau -> 3mu analysis with Run3 conditions.
## CMSSW release
```
cmsrel CMSSW_12_4_19
cd CMSSW_12_4_19/src/
cmsenv
scram b -j 8
```
N.B. to lounch the production on crab use lxplus8
## GENFRAGMENT
The genfragment path is `Configuration/GenProduction/python/ppW3MuNu_fragment.py`. It runs the `ExternalLHEProducer` cmssw-producer which takes in input a gridpack

N.B. always build the code with `scram b -j 8` after modifying the fragment

## LHE -> GEN-SIM step
Produce the configuration file with the Run3Summer22EE campaign. The condition can be retrived from [McM](https://cms-pdmv-prod.web.cern.ch/mcm/requests?dataset_name=WtoTauNu_Tauto3Mu_TuneCP5_13p6TeV_pythia8&page=0&shown=127)
```
cd production/LHE-GENSIM_production
```
if you need to change the condition modify `LHE-SIM.sh` and run
```
source LHE-SIM.sh
```
the script produces a configfile `ppW3MuNu_fragment_LHEGS_cfg_draft.py`, if existing already, it is processed via `cmsRun`.\
CRAB production : it is convenient not to produce LHE in output to save job disk quota.
