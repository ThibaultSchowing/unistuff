#!/bin/bash

#SBATCH -o somatic_map.txt
#SBATCH -e somatic_map.err

#SBATCH --job-name="somatic_mapping_stuff"
#SBATCH --time=24:00:00
#SBATCH --mem=4G
#SBATCH --partition=pcourse80
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks=1

#load modules


module add UHTS/Aligner/hisat/2.1.0;
module add UHTS/Analysis/samtools/1.8;

module add UHTS/Aligner/bwa/0.7.17;

datadir=/data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019

cd /data/users/student06/day2

#Input: Fastq files: ${datadir}/reads/*.fastq.gz
#       Reference: ${datadir}/reference/*


# Unzip the fastq files
cp /data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019/reads/*.fastq.gz .
#gzip -d *.gz


bwa mem -M -t 1 ${datadir}/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa Case_001_N_R1.fastq.gz Case_001_N_R2.fastq.gz > mappedReads_Case_001_N.sam
bwa mem -M -t 1 ${datadir}/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa Case_001_T_R1.fastq.gz Case_001_T_R2.fastq.gz > mappedReads_Case_001_T.sam



samtools view -hbS mappedReads_Case_001_N.sam > mappedReads_Case_001_N.bam
samtools view -hbS mappedReads_Case_001_T.sam > mappedReads_Case_001_T.bam



samtools sort -m 3G -@ 1 -o sorted_mappedReads_Case_001_N.bam -T temp mappedReads_Case_001_N.bam
samtools sort -m 3G -@ 1 -o sorted_mappedReads_Case_001_T.bam -T temp mappedReads_Case_001_T.bam



samtools index sorted_mappedReads_Case_001_T.bam
samtools index sorted_mappedReads_Case_001_N.bam


