#! /bin/bash

echo "> Load CRAB3 config"
source /cvmfs/cms.cern.ch/crab3/crab.sh
echo "> activate proxy"
voms-proxy-init --voms cms --valid 168:00
mv /tmp/x509up_u147779 ~/X509_USER_PROXY
export X509_USER_PROXY=~/X509_USER_PROXY
echo $X509_USER_PROXY 
