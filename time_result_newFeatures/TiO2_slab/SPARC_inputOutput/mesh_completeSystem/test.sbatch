#!/bin/bash
#SBATCH -JTiO2_mesh
#SBATCH --account=gts-phanish6
#SBATCH -N 30 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t01:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load intel
module load mvapich2

srun ../../../lib/sparc -name TiO2_HSE > TiO2.log
