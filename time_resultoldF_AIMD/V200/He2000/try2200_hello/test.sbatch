#!/bin/bash
#SBATCH -JHello_2200
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 200 --ntasks-per-node=11
#SBATCH --mem-per-cpu=7G
#SBATCH -t00:30:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load intel
module load mvapich2

srun hello > hello2200.log
