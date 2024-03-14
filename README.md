# W3MuNu_T3MRun3
Code to produce private MC sample of W -> 3mu nu (SM) for Tau -> 3mu analysis with Run3 conditions.
*CMSSW release*
```
cmsrel CMSSW_12_4_19
cd CMSSW_12_4_19/src/
cmsenv
scram b -j 8
```
N.B. to lounch the production on crab use lxplus8
*GENFRAGMENT*
The genfragment path is `Configuration/GenProduction/python/ppW3MuNu_fragment.py`. It runs the `ExternalLHEProducer` cmssw-producer which takes in input a gridpack

N.B. always build the code with `scram b -j 8` after modifying the fragment

*LHE -> GENSIM step *
