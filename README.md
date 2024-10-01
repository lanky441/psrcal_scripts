# psrcal_scripts

These scripts are used for performing polarization calibration and TOA creation for a subset of NANOGrav pulsar data taken with the Green Bank Telescope (see [Dey et al. 2024](https://arxiv.org/abs/2406.13463)). We have scripts for three different kind of polarization calibration: IFA, MEM, and MEM+METM. You can use these scripts but **be careful** as some of the commands only apply to NANOGrav observation with GBT telescope.

- To perform IFA calibration and subsequent TOA generation, follow [toagen_ifa.sh](https://github.com/lanky441/psrcal_scripts/blob/main/toagen_ifa.sh)
- To generate MEM solutions from long-track observation of a pulsar, follow the commands given in [command_flow.txt](https://github.com/lanky441/psrcal_scripts/blob/main/generate_mem_solutions/command_flow.txt) in the [generate_mem_solutions](https://github.com/lanky441/psrcal_scripts/tree/main/generate_mem_solutions) folder.
- To perform MEM calibration of pulsar observation and generate TOAs, follow [toagen_mem.sh](https://github.com/lanky441/psrcal_scripts/blob/main/toagen_mem.sh)
- To generate METM correction, follow [command_flow.txt](https://github.com/lanky441/psrcal_scripts/blob/main/generate_metm_corrections/command_flow.txt) in [generate_metm_corrections](https://github.com/lanky441/psrcal_scripts/tree/main/generate_metm_corrections) folder
- To perform MEM+METM calibration of pulsar observation and generate TOAs, follow [toagen_mem_metm.sh](https://github.com/lanky441/psrcal_scripts/blob/main/toagen_mem_metm.sh)
- Example MEM solutions and METM corrections used in [Dey et al. (2024)](https://arxiv.org/abs/2406.13463) are given in [mem_solutions](https://github.com/lanky441/psrcal_scripts/tree/main/mem_solutions) and [metm_corrections](https://github.com/lanky441/psrcal_scripts/tree/main/metm_corrections), respectively
