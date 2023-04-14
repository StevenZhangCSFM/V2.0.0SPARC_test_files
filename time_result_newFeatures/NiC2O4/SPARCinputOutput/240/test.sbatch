#!/bin/bash
#SBATCH -JNiC2O4_240
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 20 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t01:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name NiC2O4 > NiC2O4.log
