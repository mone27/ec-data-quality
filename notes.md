### 28 sept 2021

First meeting about the project.

The goal is now to start exploring how the different EC processing packages deal with data quality.

Then we are going to have a machine learning model (probably random forest) that is going to predict the data quality of half an hour from the metoerogical data.

EddyPro raw statistical screening [https://www.licor.com/env/support/EddyPro/topics/despiking-raw-statistical-screening.html](https://www.licor.com/env/support/EddyPro/topics/despiking-raw-statistical-screening.html)

EddyPro micrometerogial test
[https://www.licor.com/env/support/EddyPro/topics/flux-quality-flags.html](https://www.licor.com/env/support/EddyPro/topics/flux-quality-flags.html)

### EddyPro
Hand book of micrometerology notes:

the statistical tests are:

 - steady state test -> there not a big change in statistic parameter along the averaging period
 - development of turbulent conditions 
 
overall flag for class of quality

This is the systems implemented in EddyPro

This is implemented by Eddy Pro EddyPro micrometerogial test
[https://www.licor.com/env/support/EddyPro/topics/flux-quality-flags.html](https://www.licor.com/env/support/EddyPro/topics/flux-quality-flags.html)
with the support of different flagging system.



#### *Papale et al. 2006*
https://bg.copernicus.org/articles/3/571/2006/

spike removal also in the half an hour data, checked on a period of 13 days

complex method to find u* threshold, if u* is below data is removed


#### RFlux - *Vitale et al. 2020*
https://bg.copernicus.org/articles/17/1367/2020/

is an R interface to EddyPro + add quality control and assurance for detail 

importance of automation

set of test (5) that if we are above a threshold (SevEr)
resulting in discording the data, while for another range (ModEr) 
are discarded only  if the resulting flux is an outlier.

they look at the high frequency data 

3 possible sources of systematic errors:

1. instrumental issues
2. poorly developed turbulence regimes
3. non-stationary conditions.

type of error checking:

| Source of error                 | Test statistic                                     | Threshold values |        |      |
|---------------------------------|----------------------------------------------------|------------------|--------|------|
| NoEr                            | ModEr                                              | SevEr            |        |      |
| (1) EC system malfunction      | "(1a) Fraction of missing records (FMR, %)"        | ≤5               | ≤15    | >15  |
| and disturbances                | "(1b) Longest gap duration (LGD, s)"               | ≤90              | ≤180   | >180 |
|                                 | (2) R2 for linear regression of CCFs               |                  |        |      |
| (2) Low signal resolution       | estimated with original data and after             | >0.995           | ≤0.995 |      |
|                                 | removal of repeated contiguous values              |                  |        |      |
|                                 | Homogeneity test of fluctuations:                  |                  |        |      |
|                                 | (3a) HF5 – percent of fluctuations beyond ±5σ      | ≤2               | ≤4     | >4   |
| (3) Aberrant structural changes| (3b) HF1 percent of fluctuations beyond ±10σ       | ≤0.5             | ≤1     | >1   |
| "(e.g. sudden shift in mean,"   | Homogeneity test of differenced data:              |                  |        |      |
| changes in variance)            | (3c) HD5 – percent of differenced data beyond ±5σ  | ≤2               | ≤4     | >4   |
|                                 | (3d) HD1 – percent of differenced data beyond ±10σ | ≤0.5             | ≤1     | >1   |
|                                 | (3e) KID – kurtosis index of differenced data      | ≤30              | ≤50    | >50  |
| (4) Poorly developed            | (4) Integral turbulence characteristics (%)        | ≤30              | ≤100   | >100 |
| turbulence regimes              | by                                                 |                  |        |      |
| (5) Non-stationary conditions   | (5) Non-stationary ratio by                        | ≤2               | ≤3     | >3   |


#### OpenEddy
https://github.com/lsigut/EC_workflow#readme 

No clear paper on OpenEddy
main reference is *Maudeder 2013* https://www.sciencedirect.com/science/article/abs/pii/S0168192312002808

(still need to finalize review of it)



#### REddyProc *Wutzler et al. 2018*
https://bg.copernicus.org/articles/15/5015/2018/

only for post processing  
u* threshold, as well as gap-filling, flux-partitioning


what is does is:
 - u* filtering
 - gap filling
 - flux partitioning

Interesting reference https://ieeexplore.ieee.org/abstract/document/6972274 


#### ONEFlux
https://www.nature.com/articles/s41597-020-0534-3

processing steps take from README on github
- **`01_qc_visual/`**: output of QA/QC procedures and visual inspection of data; _this is the main input for the ONEFlux pipeline_.
- **`02_qc_auto/`**: output of data preparation procedures for next steps and automated flagging of data based on quality tests (this step is implemented in C, and source available under `../ONEFlux/oneflux_steps/qc_auto/`).
- (*step 03* is part of a secondary visual inspection and not included in this codebase)
- **`04_ustar_mp/`**: output of the Moving Point detection method for USTAR threshold estimation 
- **`05_ustar_cp/`**: output of the Change Point detection method for USTAR threshold estimation `).
- **`06_meteo_era/`**: output of the downscaling of micromet data using the ERA-Interim dataset 
- **`07_meteo_proc/`**: output of the micromet processing step, including gap-filling 
- **`08_nee_proc/`**: output of the NEE processing step, including gap-filling 
- **`09_energy_proc/`**: output of the energy (LE and H) processing step, including gap-filling
- **`10_nee_partition_nt/`**: output of the NEE partitioning, nighttime method
- **`11_nee_partition_dt/`**: output of the NEE partitioning, daytime method 
- **`12_ure_input/`**: output of the preparation of input for the uncertainty estimation step 
- **`12_ure/`**: output of the uncertainty estimation step
- **`99_fluxnet2015/`**: final output of the pipeline with combined products from previous steps


#### Eddy Covariance Raw data processing *Sabbatini et al. 2018*
https://www.research-collection.ethz.ch/handle/20.500.11850/313355

system used in ICOS

flagging with data quality 0,1,2
tests:
- Completeness of the averaging interval
- Absolute limits test
- De-spiking
- Wind direction test
- Amplitude resolution test
- Drop out test
- Instruments diagnostics

Then it describes the "normal" Eddy Covariance processing pipeline


#### Wharton 2009
https://www.sciencedirect.com/science/article/pii/S0168192309000872

Nothing particular in the QA








 
 





