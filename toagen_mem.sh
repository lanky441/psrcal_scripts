# Bash script for performing MEM calibration and genrate TOAs from those calibrate profiles

pac -w -u cf -u fcal -u mem
mv database.txt database.mem.txt
pac -ST -a -d database.mem.txt -e mem.calib guppi*.rf
echo "#MJD      RM" > mem_RM.txt
for file in guppi*.mem.calib; do
    rmfit -r -m -100,100,128 -B 4 $file >& rmout.txt
    RMtxt=$(grep "final rotation measure" rmout.txt | awk {'print $5}')
    RM=${RMtxt:1:7}
    echo "${file:6:5}   $RM" >> mem_RM.txt
    pam -R $RM -e calib.rmfit $file
done
paz -m -E2.0 -F "794.6 798.6" -F "814.1 820.7" guppi*.mem.calib.rmfit
psrsh -e zap ../zap_minmax guppi*.mem.calib.rmfit
normalize_rms -w guppi*.mem.calib.zap
for file in guppi*.mem.calib.norm; do
    pam -e ff -f2 --setnsub `psredit -Q -c length $file | awk '{print int($2/1800) + 1}'` $file
done
autotoa -g0.1 -i3 -S guppi.rcvr800.mem.sum guppi*.mem.calib.ff
pam -r 0.5 -m guppi.rcvr800.mem.sum
psrsmooth -W -t UD8 guppi.rcvr800.mem.sum
echo 'MODE 1' > guppi.rcvr800.mem.tim
pat -A FDM -e err=num -C chan -C subint -C snr -C wt -C flux -C fluxe -f "tempo2 IPTA" -X "-proc 15y -pta NANOGrav" -s guppi.rcvr800.mem.sum.sm guppi*.mem.calib.ff >> guppi.rcvr800.mem.tim
