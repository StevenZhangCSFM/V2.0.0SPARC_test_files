#!/bin/bash
#SBATCH -JC_75
#SBATCH --account=gts-phanish6
#SBATCH -N 2 --ntasks-per-node=24
#SBATCH --mem-per-cpu=7G
#SBATCH -t2:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load mkl
module load mvapich2

srun ../../../lib/sparc -name c_tube > c_tube.log
