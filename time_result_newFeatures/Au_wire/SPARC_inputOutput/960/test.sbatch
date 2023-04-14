#!/bin/bash
#SBATCH -JAu_SOC_960
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 80 --ntasks-per-node=12
#SBATCH --mem-per-cpu=12G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name Au72_SOC > Au72_SOC.log
