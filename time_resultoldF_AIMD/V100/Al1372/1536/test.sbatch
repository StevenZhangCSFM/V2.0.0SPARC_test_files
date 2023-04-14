#!/bin/bash
#SBATCH -JAl1372_1536
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 128 --ntasks-per-node=12
#SBATCH --mem-per-cpu=12G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name Al1372 > Al1372.log
