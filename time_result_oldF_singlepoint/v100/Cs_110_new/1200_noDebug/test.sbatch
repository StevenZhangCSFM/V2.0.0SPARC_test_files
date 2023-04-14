#!/bin/bash
#SBATCH -JCs_110_1200
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 100 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load intel
module load mvapich2

srun ../../../lib/sparc -name Cs_110_surface > Cs_110.log
