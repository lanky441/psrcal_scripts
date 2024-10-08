#!/bin/bash
#psredit -c polc=0 -e calib0 guppi*mem.calib
for f in guppi_*.mem.calib0
do
        mjd=${f:6:5}
        sep=1000
        for metm in $(ls metm_solutions/*.metm.fz)
        do
                pcmmjd=${metm:19:5}
                isep=$(echo "$mjd - $pcmmjd" | bc -l)
                if (( $(echo "${isep#-} < $sep" | bc -l) ))
                then
                        sep=${isep#-}
                        closest=$metm
                fi
        done
	echo $f $closest
        pac -A $closest -e metm.calib $f
done
paz -m -E2.0 -F "794.6 798.6" -F "814.1 820.7" guppi*.mem.metm.calibP
psrsh -e zap zap_minmax guppi*.mem.metm.calibP
normalize_rms -w guppi*.mem.metm.zap
for file in guppi*.mem.metm.norm; do
        pam -e ff -f2 --setnsub `psredit -Q -c length $file | awk '{print int($2/1800) + 1}'` $file
done
autotoa -g0.1 -i3 -S guppi.rcvr800.mem.metm.sum guppi*.mem.metm.ff
pam -r 0.5 -m guppi.rcvr800.mem.metm.sum
psrsmooth -W -t UD8 guppi.rcvr800.mem.metm.sum
echo 'MODE 1' > J1744-1134.rcvr800.mem.metm.tim
pat -A FDM -e err=num -C chan -C subint -C snr -C wt -C flux -C fluxe -f "tempo2 IPTA" -X "-proc 15y -pta NANOGrav" -s guppi.rcvr800.mem.metm.sum.sm guppi*.mem.metm.ff >> J1744-1134.rcvr800.mem.metm.tim
