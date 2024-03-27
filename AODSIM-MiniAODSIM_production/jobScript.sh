#echo "================= CMSRUN starting Step 1 ====================" >> job.log
#cmsRun -e -j ppW3MuNu_Run3Summer22EEDRPremix.log -p ppW3MuNu_Run3Summer22EEDRPremix_cfg.py 
#echo "================= CMSRUN finished Step 1 ====================" >> job.log
#echo "================= CMSRUN starting Step 2 ====================" >> job.log
#cmsRun -e -j ppW3MuNu_Run3Summer22EEAODsim.log -p ppW3MuNu_Run3Summer22EEAODsim_cfg.py
#echo "================= CMSRUN finished Step 2 ====================" >> job.log
echo "================= CMSRUN starting Step 3 ====================" >> job.log
cmsRun -e -j FrameworkJobReport.xml PSet.py
echo "================= CMSRUN finished Step 3 ====================" >> job.log

