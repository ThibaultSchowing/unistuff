#!/bin/bash

#SBATCH -o annotate_strelka_thing.txt
#SBATCH -e annotate_strelka_thing.err

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

cd /data/users/student06/day2/part6
datadir=/data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019

# Input: ${datadir}/strelka/myOutputFolder/results/variants/*.vcf

# /data/courses/cancergenomics/SomaticVariantCalling_CancerGenomics_2019/strelka/Case_001/results/variants/*.vcf.gz

java -Xmx4000M -jar /mnt/apps/centos7/snpEff_4.3T/snpEff/snpEff.jar -canon -v GRCh38.86 ${datadir}/strelka/Case_001/results/variants/somatic.indels.vcf > Case001_annotated_indels.vcf
java -Xmx4000M -jar /mnt/apps/centos7/snpEff_4.3T/snpEff/snpEff.jar -canon -v GRCh38.86 ${datadir}/strelka/Case_001/results/variants/somatic.snvs.vcf > Case001_annotated_somatic.vcf

