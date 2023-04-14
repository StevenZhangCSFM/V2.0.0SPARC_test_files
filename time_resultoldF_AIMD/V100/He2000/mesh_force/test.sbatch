#!/bin/bash
#SBATCH -JHe2000_mesh
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 64 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:30:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load intel
module load mvapich2

srun ../../../lib/sparc -name He2000 > He2000.log
