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
#module add UHTS/Quality_control/fastqc/0.11.7

module add UHTS/Aligner/hisat/2.1.0;
module add UHTS/Analysis/samtools/1.8;


# Change the read you want here

READ=Normal1_chr22
READ1=Normal1_chr22_R1
READ2=Normal1_chr22_R2

STUDENT=student06


datadir=/data/courses/cancergenomics/RNAseq_CancerGenomics_2019/chr22


cd /data/users/${STUDENT}/input_files

# Reads have already been soft-linked before. 
# ln -s ${datadir}/reads/${READ} ${READ}

# Don't forget to change the name of the outputs

hisat2 -x ${datadir}/reference/Homo_sapiens.GRCh38.dna.chromosome.22 -1 ${READ1}.fastq.gz -2 ${READ2}.fastq.gz -S mappedReads_${READ}.sam -p 1

samtools view -hbS mappedReads_${READ}.sam > mappedReads_${READ}.bam

# 4GB of RAM should be sufficient
samtools sort -m 4G -@ 1 -o sorted_mappedReads_${READ}.bam -T temp mappedReads_${READ}.bam

samtools index sorted_mappedReads_${READ}.bam


