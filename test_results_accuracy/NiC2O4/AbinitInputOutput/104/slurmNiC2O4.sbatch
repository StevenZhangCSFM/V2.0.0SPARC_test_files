#!/bin/bash
#SBATCH -JAbi104
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 1 --ntasks-per-node=10
#SBATCH --mem-per-cpu=7G
#SBATCH -t5:00:00
#SBATCH -oReport-%j.out

cd $SLURM_SUBMIT_DIR

module load gcc
module load mvapich2
module load abinit

srun abinit < NiC2O4.files