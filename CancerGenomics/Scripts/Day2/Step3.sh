#!/bin/bash

#SBATCH -o marc_duplicates.txt
#SBATCH -e marc_duplicates.err

#SBATCH --job-name="somatic_mapping_stuff"
#SBATCH --time=24:00:00
#SBATCH --mem=4G
#SBATCH --partition=pcourse80
#SBATCH --cpus-per-task=2
#SBATCH --nodes=1
#SBATCH --ntasks=1

#load modules


module add UHTS/Aligner/hisat/2.1.0;
module add UHTS/Analysis/samtools/1.8;
module add UHTS/Analysis/picard-tools/2.18.11;

cd /data/users/student06/day2/part34
datadir=/data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019

java -Xmx1G -jar /software/UHTS/Analysis/picard-tools/2.18.11/bin/picard.jar MarkDuplicates INPUT=${datadir}/rg/Case_001_N.coordSorted.rg.bam OUTPUT=Case_001_N.coordSorted.rg.dedup.bam METRICS_FILE=Case_001_N_dedup.metrics.txt CREATE_INDEX=true OPTICAL_DUPLICATE_PIXEL_DISTANCE=100

java -Xmx1G -jar /software/UHTS/Analysis/picard-tools/2.18.11/bin/picard.jar MarkDuplicates INPUT=${datadir}/rg/Case_001_T.coordSorted.rg.bam OUTPUT=Case_001_T.coordSorted.rg.dedup.bam METRICS_FILE=Case_001_T_dedup.metrics.txt CREATE_INDEX=true OPTICAL_DUPLICATE_PIXEL_DISTANCE=100

