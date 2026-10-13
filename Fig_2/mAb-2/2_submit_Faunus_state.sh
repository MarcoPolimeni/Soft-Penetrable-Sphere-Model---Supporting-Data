#!/bin/bash
#SBATCH --job-name=Repo
#SBATCH --tasks-per-node=1
##SBATCH --mem=1G
#SBATCH --time=24:00:00
#SBATCH -J Repo_r
#SBATCH -o out
#SBATCH -e err

export OMP_NUM_THREADS=1;/groups/cms/marpoli/Software/Faunus/scripts/yason.py input.yml | /groups/cms/marpoli/Software/Faunus/faunus --state state.json -v 6 > out
