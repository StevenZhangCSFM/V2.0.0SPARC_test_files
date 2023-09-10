#!/bin/bash
#SBATCH -JAu_SOC
#SBATCH --account=gts-phanish6-coda20
#SBATCH -N 8 --ntasks-per-node=12
#SBATCH --mem-per-cpu=7G
#SBATCH -t4:00:00
#SBATCH -oReport-%j
cd $SLURM_SUBMIT_DIR

module purge
module load anaconda3
module load intel
module load mvapich2

python fdn_test.py -name Au16_SOC -atomn 16 > result.log
