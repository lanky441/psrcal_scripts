for f in guppi_*.rmfit; do
        pcm -H -s -Q -n 32 -t 8 -S guppi_56614_B1937+21_0016.15y.mem.calib.rmfit.template $f
        mv pcm.fits "metm_solutions/pcm_${f:6:5}.metm"
done
