#!/bin/bash
#SBATCH -JBi_111_96
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 16 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t1:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun ../../../lib/sparc -name Bi_111 > Bi_111.log
