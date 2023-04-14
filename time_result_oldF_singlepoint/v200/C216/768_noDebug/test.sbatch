#!/bin/bash
#SBATCH -JC216_768
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 32 --ntasks-per-node=24
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name C216 > C216.log
