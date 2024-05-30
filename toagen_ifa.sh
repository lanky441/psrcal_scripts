# Bash script for performing IFA calibration and genrate TOAs from those calibrate profiles

pac -w -u cf -u fcal
mv database.txt database.ifa.txt
pac -a -j "config SquareWave::transition_phase=0.5" -x -e ifa.calib -d database.ifa.txt guppi_*.rf
paz -m -E2.0 -F "794.6 798.6" -F "814.1 820.7" guppi*.ifa.calib
psrsh -e zap ../zap_minmax guppi*.ifa.calib
normalize_rms -w guppi*.ifa.zap
for file in guppi*.ifa.norm; do
    pam -e ff -f2 --setnsub `psredit -Q -c length $file | awk '{print int($2/1800) + 1}'` $file
done
autotoa -g0.1 -i3 -S guppi.rcvr800.ifa.sum guppi*.ifa.ff
pam -r 0.5 -m guppi.rcvr800.ifa.sum
psrsmooth -W -t UD8 guppi.rcvr800.ifa.sum
echo 'MODE 1' > guppi.rcvr800.ifa.tim
pat -A FDM -e err=num -C chan -C subint -C snr -C wt -C flux -C fluxe -f "tempo2 IPTA" -X "-proc 15y -pta NANOGrav" -s guppi.rcvr800.ifa.sum.sm guppi*.ifa.ff >> guppi.rcvr800.ifa.tim
