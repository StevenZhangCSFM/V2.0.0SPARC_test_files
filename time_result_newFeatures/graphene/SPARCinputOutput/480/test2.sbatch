#!/bin/bash
#SBATCH -Jgraphene_480
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 40 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t00:30:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module purge
module load anaconda3
module load intel
module load mvapich2

srun ../../../lib/sparc -name graphene_z30 > graphene.log
