#!/bin/bash
#SBATCH -JQEAu480
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 40 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t06:00:00
#SBATCH -oReport-%j.out
cd $SLURM_SUBMIT_DIR

module purge
module load gcc
module load mvapich2
module load quantum-espresso

srun pw.x -pd true -in pw_soc_cg.inp > output.out
rm -r calc.save