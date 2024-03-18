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
```
cd LHE-GENSIM_production
```
Configuration files are produced with the Run3Summer22EE campaign conditions ([McM](https://cms-pdmv-prod.web.cern.ch/mcm/requests?dataset_name=WtoTauNu_Tauto3Mu_TuneCP5_13p6TeV_pythia8&page=0&shown=127)).\
If you don't need to change such configuration just modify the number of events, the gridpack location and wheter you want to run on CRAB or not in `privateproduction_LHEGS.sh`, then run
```
source privateproduction_LHEGS.sh
```
the code will produce the config files `ppW3MuNu_fragment_LHEGS_cfg.py` and `crabconfig.py` with the gridpack location and number of events accordingly.
> [!NOTE]
>If you need to **change the campaign conditions** modify `LHE-SIM.sh` and run
>```
>rm ppW3MuNu_fragment_LHEGS_cfg_draft.py
>source LHE-SIM.sh
>```
>The script produces a configfile `ppW3MuNu_fragment_LHEGS_cfg_draft.py` (if existing already, it is processed via `cmsRun`).
## GEN-SIM -> AODSIM step
```
cd  GENSIM-AODSIM_production
```
If you want to produce AODSIM data with Run3Summer22EE configuration just just modify the number of events and the GENSIM data location in `privateproduction_GENSimAODSim.py`


