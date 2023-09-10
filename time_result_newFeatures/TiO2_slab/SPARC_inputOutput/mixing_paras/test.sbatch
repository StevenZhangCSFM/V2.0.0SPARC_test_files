#!/bin/bash
#SBATCH -JNiC2O4_script
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 30 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t03:00:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module purge
module load anaconda3
module load intel
module load mvapich2

python mix_test.py -name TiO2_HSE_44 -atomn 96 > result.log
