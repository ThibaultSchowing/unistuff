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
module add UHTS/Analysis/subread/1.6.0;


# Step 3: Count the number of reads overlapping annotated genes

datadir=/data/courses/cancergenomics/RNAseq_CancerGenomics_2019/chr22

bams=${datadir}/mapped/*.bam
annot=${datadir}/reference/Homo_sapiens.GRCh38.98.gtf


# featureCounts takes as input SAM/BAM files and an annotation file including chromosomal coordinates of features. It outputs numbers of reads assigned to features (or meta-features). It also outputs stat info for the overall summrization results, including number of successfully assigned reads and number of reads that failed to be assigned due to various reasons (these reasons are included in the stat info).



featureCounts -p -C -s 2 -T 1 -Q 10 -a ${annot} -t exon -g gene_id -o output_feature_count.txt ${bams}







