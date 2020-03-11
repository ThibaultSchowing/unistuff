#!/bin/bash

# Script to extract genotypes (GT field) from a VCF file
# creates a matrix with genotypes coded as 0, 1, 2, -1 (missing data)
# from a VCF
#
# author: Vitor Sousa
# last updated: 19/11/2019
#
# REQUIRES: 
#   - vcftools
#   - bcftools
# NOTE: the vcf can only contain BIALLELIC SITES!

# SETTINGS - Modify the following values 
# tag for VCF file (vcf file with format "vcffile".vcf)
vcffile="merge_indDP_10Kb_snps";   

# Get GT field with bcftools
bcftools query -f '[%GT\t]\n' ${vcffile}.vcf.gz > ${vcffile}.GT

# Replace 0/0 by 0 # Replace 0/1 by 1 # Replace 1/1 by 2 # Replace ./. by -1 # Replace . by -1
sed -i "s/0\/0/0/g;s/0\/1/1/g;s/1\/0/1/g;s/1\/1/2/g;s/\.\/./-1/g;s/\./-1/g" ${vcffile}.GT

# Get DP field (depth of coverage)
bcftools query -f '[%DP\t]\n' ${vcffile}.vcf.gz > ${vcffile}.DP
# replace missing data by zero depth of coverage
sed -i "s/\.\t/0\t/g" ${vcffile}.DP

# Get the list of individuals in the VCF file
zgrep -i -m 1 "#CHROM" ${vcffile}.vcf.gz > indsIn${vcffile}.txt


