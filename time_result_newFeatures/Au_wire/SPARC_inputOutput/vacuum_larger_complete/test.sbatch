#!/bin/bash
#SBATCH -JAu_vacuum
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 12 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t4:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2


srun ../../../lib/sparc -name Au72_SOC_18 > Au72_SOC_18.log