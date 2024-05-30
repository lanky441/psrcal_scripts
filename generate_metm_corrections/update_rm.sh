#!/bin/bash
echo "#MJD      RM" > B1937+21_RM.txt
for file in guppi*.mem.calib; do
    rmfit -r -m -100,100,128 -B 4 $file >& rmout.txt
    RMtxt=$(grep "final rotation measure" rmout.txt | awk {'print $5}')
    RM=${RMtxt:1:7}
    echo "${file:6:5}   $RM" >> B1937+21_RM.txt
    pam -R $RM -e calib.rmfit $file
done
