#!/bin/bash

#SBATCH -o fastqc_sample1.txt
#SBATCH -e fastqc_sample1.err

#SBATCH --job-name="FastQC_sample1"
#SBATCH --time=24:00:00
#SBATCH --mem=4G
#SBATCH --partition=pcourse80
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks=1

#load modules
module add UHTS/Quality_control/fastqc/0.11.7

READ=Normal1_chr22_R1.fastq.gz

mkdir /data/users/student06/input_files
cd /data/users/student06/input_files

ln -s /data/courses/cancergenomics/RNAseq_CancerGenomics_2019/chr22/reads/${READ} ${READ}


srun fastqc --extract ${READ} --threads 1


