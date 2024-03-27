# W3MuNu_T3MRun3
Code to produce private MC sample of W -> 3mu nu (SM) for Tau -> 3mu analysis with Run3 conditions.
## CMSSW release
In order to be able to use CRAB loginin lxplus8.
For LHE-GEN and GEN-AOD step use `CMSSW_12_4_19` :
```
cmsrel CMSSW_12_4_19
cd CMSSW_12_4_19/src/
cmsenv
scram b -j 8
git clone git@github.com:BasChiara/W3MuNu_T3MRun3.git
```
for AOD-MiniAOD step use `CMSSW_13_0_13` instead
```
cmsrel CMSSW_13_0_13 
cd CMSSW_13_0_13/src/
cmsenv
scram b -j 8
git clone git@github.com:BasChiara/W3MuNu_T3MRun3.git
```
## GENFRAGMENT
The genfragment `Configuration/GenProduction/python/ppW3MuNu_fragment.py` runs the `ExternalLHEProducer`, the cmssw-producer which takes in input the gridpack.
N.B. always build the code with `scram b -j 8` after modifying the fragment

## LHE -> GEN-SIM step
```
cd LHE-GENSIM_production
```
The code in this folder produces GENSIM files starting from a Madgraph gridpack.
Configuration files are produced with the Run3Summer22EE campaign conditions ([McM](https://cms-pdmv-prod.web.cern.ch/mcm/requests?dataset_name=WtoTauNu_Tauto3Mu_TuneCP5_13p6TeV_pythia8&page=0&shown=127)).\
If you don't need to change such configuration in `privateproduction_LHEGS.sh` just set the parameter `NUMBEREVENTS` and `USECRAB` to the desired values, then run
```
./privateproduction_LHEGS.sh
```
the code will produce the config files `ppW3MuNu_fragment_LHEGS_cfg.py`, if `USECRAB` is set it also produce the CRAB config file `crabconfig.py`, with the gridpack location and number of events as specified in the set-up. The production is then lounched.
> [!NOTE]
>If you need to **change the campaign conditions** modify `LHE-SIM.sh` accorndingly and run
>```
>rm ppW3MuNu_fragment_LHEGS_cfg_draft.py
>./LHE-SIM.sh
>```
>The script produces a configfile `ppW3MuNu_fragment_LHEGS_cfg_draft.py` (if existing already, it is processed via `cmsRun`).
## GEN-SIM -> AODSIM step
```
cd  GENSIM-AODSIM_production
```
The code in this folder produce AODSIM files starting from the GEN files produced in the previous step. It execute DRPremix and RECO step in one go wrapped together in the executable `jobScript.sh`.
If you want to produce AODSIM data with Run3Summer22EE configuration just modify `crabconfig.py` with the GENSIM dataset with its name on DAS.
N.B. running on private files is also possible (work in progress)
Start the production using crab simply running
```
./setup_crab.sh
python3 crabconfig.py
```
## AODSIM -> MiniAODSIM step (W.I.P)
The code here produce MiniAOD files starting from AODs produced in the previous step.
If you want to produce AODSIM data with Run3Summer22EE configuration just modify `crabconfig.py` with the GENSIM dataset with its name on DAS.

