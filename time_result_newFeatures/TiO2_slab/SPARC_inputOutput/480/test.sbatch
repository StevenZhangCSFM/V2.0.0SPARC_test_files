#!/bin/bash
#SBATCH -JTiO2_480
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 40 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t01:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load intel
module load mvapich2

srun ../../../lib/sparc -name TiO2_HSE_44 > TiO2.log
