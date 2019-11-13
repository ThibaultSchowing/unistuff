#!/bin/bash

#SBATCH -o deaf_coverage.txt
#SBATCH -e deaf_coverage.err

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

module add UHTS/Analysis/GenomeAnalysisTK/3.7;
java -Xmx2000M -jar /software/UHTS/Analysis/GenomeAnalysisTK/3.7/bin/GenomeAnalysisTK.jar \
-T DepthOfCoverage \
-R ${datadir}/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
-I ${datadir}/dedup/Case_001_N.coordSorted.rg.dedup.bam \
-o ./depth/Case_001_N \
-L ${datadir}/targets/KRAS_TP53_CDKN2C_targets_GRCh38.bed \
--minBaseQuality 10 --minMappingQuality 10 --summaryCoverageThreshold 15 \
--omitDepthOutputAtEachBase --countType COUNT_FRAGMENTS_REQUIRE_SAME_BASE



