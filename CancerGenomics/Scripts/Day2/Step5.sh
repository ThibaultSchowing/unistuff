#!/bin/bash

#SBATCH -o strelka_thing.txt
#SBATCH -e strelka_thing.err

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
module add UHTS/Analysis/GenomeAnalysisTK/3.7;
module add UHTS/Analysis/strelka/2.9.6;

cd /data/users/student06/day2/part34
datadir=/data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019


/software/UHTS/Analysis/strelka/2.9.6/bin/configureStrelkaSomaticWorkflow.py \
--tumorBam ${datadir}/dedup/Case_001_T.coordSorted.rg.dedup.bam --normalBam ${datadir}/dedup/Case_001_N.coordSorted.rg.dedup.bam \
--referenceFasta ${datadir}/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--callRegions ${datadir}/targets/KRAS_TP53_CDKN2C_targets_GRCh38.bed.gz --exome \
--runDir ./strelka

