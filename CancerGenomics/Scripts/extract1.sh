#!/bin/bash

#SBATCH -o map.txt
#SBATCH -e map.err

#SBATCH --job-name="mapping_stuff"
#SBATCH --time=24:00:00
#SBATCH --mem=4G
#SBATCH --partition=pcourse80
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks=1

#load modules


module add UHTS/Aligner/hisat/2.1.0;
module add UHTS/Analysis/samtools/1.8;

samtools view -hbS sorted_mappedReads_Normal1_chr22.bam "Chr22:0-1000000" > extracted.bam
samtools index extracted.bam



