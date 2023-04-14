#!/bin/bash
#SBATCH -J103
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 2 --ntasks-per-node=24
#SBATCH --mem-per-cpu=7G
#SBATCH -t00:45:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load mkl
module load mvapich2

srun ../../../lib/sparc -name NiC2O4 > NiC2O4.log
