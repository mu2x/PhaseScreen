#qsub -I -X -l walltime=04:00:00 -l select=1:ncpus=16:mpiprocs=16 -l place=scatter:excl -A AFDEM35714317 -q interactiveVK -V
#qsub -I -l walltime=08:00:00 -l select=1:ncpus=4:mpiprocs=4 -l place=scatter:excl -A AFDEM35714317 -q standard -V
#https://www.mhpcc.hpc.mil/doc/riptideUserGuide.html#BatchSchedul4
