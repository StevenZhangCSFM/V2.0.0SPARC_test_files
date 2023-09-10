#!/bin/bash
#SBATCH -JNiC2O4_script
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 4 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t00:30:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module purge
module load anaconda3
module load intel
module load mvapich2

python mix_test.py -name NiC2O4 -atomn 14 > result.log
