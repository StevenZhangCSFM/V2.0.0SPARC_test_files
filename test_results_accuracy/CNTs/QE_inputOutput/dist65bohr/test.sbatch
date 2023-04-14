#!/bin/bash
#SBATCH -JQECNT65
#SBATCH --account=gts-phanish6
#SBATCH -N 1 --ntasks-per-node=24
#SBATCH --mem-per-cpu=7G
#SBATCH -t2:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load gcc
module load mvapich2
module load quantum-espresso

srun pw.x -in pw.inp > output.out
