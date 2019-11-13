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
module add UHTS/Analysis/samtools/1.8


module add UHTS/Analysis/picard-tools/2.18.11;

cd /data/users/student06/day2

java -Xmx1000M -jar /software/UHTS/Analysis/picard-tools/2.18.11/bin/picard.jar AddOrReplaceReadGroups \
I=sorted_mappedReads_Case_001_T.bam O=sorted_mappedReads_Case_001_T.rg.bam \
RGID=C2P0JACXX.6 RGLB=libraryyyyiiiiiiiID RGPL=illumina RGSM=Case01_Tumor RGPU=C2P0JACXX.6.Case01_Tumor

datadir=/data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019






