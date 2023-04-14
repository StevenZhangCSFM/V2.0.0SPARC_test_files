#!/bin/bash
#SBATCH -JQENiC2O4480
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 40 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t01:00:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module load gcc
module load mvapich2
module load mkl
module load netlib-scalapack

# srun ../../../qe-7.1/bin/pw.x -pd true -in pw.inp > output.out

srun ../../../qe-7.1/bin/pw.x -in pw.inp > output.out
rm -r calc.save