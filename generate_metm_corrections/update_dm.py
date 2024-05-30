import numpy as np
import matplotlib.pyplot as plt
import subprocess
import glob
import os

dm = 71.100060
mean_dmx = -3.805011e-04
fd_offset = -0.07944 #Offset in DM due to FD params

dmx_file = np.genfromtxt("B1937_dmx.txt", dtype="str")

mjds = np.array([float(x) for x in dmx_file.transpose()[0]])
dmxs = np.array([float(x) for x in dmx_file.transpose()[1]])
dmx_errs = np.array([float(x) for x in dmx_file.transpose()[2]])

dms = dm + mean_dmx + fd_offset + dmxs

# plt.errorbar(mjds, dms, yerr=dmx_errs, fmt='o', capsize=3)
# plt.show()


files = sorted(glob.glob("*.rf"))


closest = 0
for file in files[:]:
    mjd = int(file[6:11])
    diff = 1e4
    for i in range(0, len(mjds)):
        diff_new = np.abs(mjd - mjds[i])
        if diff_new < diff:
            closest = i
            diff = diff_new
    dm = dms[closest]
    print(file, mjds[closest], dms[closest])
    subprocess.run(f"pam -d {dm} -e dmcorr {file}", shell=True)