#!/bin/bash
#SBATCH -JAl500_450
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 45 --ntasks-per-node=10
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name Al500 > Al500.log
