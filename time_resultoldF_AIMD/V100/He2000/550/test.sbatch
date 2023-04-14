#!/bin/bash
#SBATCH -JHe2000_550
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 50 --ntasks-per-node=11
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name He2000 > He2000.log
