#!/bin/bash
#SBATCH -JQECNT6
#SBATCH --account=gts-phanish6
#SBATCH -N 4 --ntasks-per-node=6
#SBATCH --mem-per-cpu=7G
#SBATCH -t00:30:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module load gcc
module load mvapich2
module load quantum-espresso

srun pw.x -in pw.inp > output.out
