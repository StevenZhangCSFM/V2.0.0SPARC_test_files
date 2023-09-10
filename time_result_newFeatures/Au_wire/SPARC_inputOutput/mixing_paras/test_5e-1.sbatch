#!/bin/bash
#SBATCH -JAu_SOC_5
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 10 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load mkl
module load mvapich2

srun ../../../lib/sparc -name Au72_SOC_mix5e-1 > Au72_SOC_5e-1.log
