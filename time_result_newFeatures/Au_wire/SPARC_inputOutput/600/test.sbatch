#!/bin/bash
#SBATCH -JAu_SOC_600
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 50 --ntasks-per-node=12
#SBATCH --mem-per-cpu=12G
#SBATCH -t00:20:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load mvapich2
module load intel

srun ../../../lib/sparc -name Au72_SOC > Au72_SOC.log
