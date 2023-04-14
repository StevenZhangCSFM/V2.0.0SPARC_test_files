#!/bin/bash
#SBATCH -Jgraphene_240
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 20 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t01:00:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module purge
module load anaconda3
module load intel
module load mvapich2

srun ../../../lib/sparc -name graphene_z30 > graphene.log
