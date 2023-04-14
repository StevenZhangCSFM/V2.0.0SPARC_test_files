#!/bin/bash
#SBATCH -JAl4_mesh
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 8 --ntasks-per-node=12
#SBATCH --mem-per-cpu=12G
#SBATCH -t2:30:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load intel
module load mvapich2

srun ../../../lib/sparc -name Al4 > Al4.log
