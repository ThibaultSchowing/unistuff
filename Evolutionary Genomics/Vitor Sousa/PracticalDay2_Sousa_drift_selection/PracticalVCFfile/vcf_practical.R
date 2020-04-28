# Evo genomics  - vcf practical


library(vcfR)

# read VCF file
vcf <- read.vcfR("pinf_sc50.vcf", verbose = FALSE )
# print info about the vcf
vcf

# Show the meta information
head(vcf@meta)

# check what is a given element of the VCF
queryMETA(vcf, element = 'DP')
# this will give information about the DP fields that appear in the fix and genotype information

# Fix region (info for each site and sample)
head(getFIX(vcf))
# What info do we have for each site?

# - Chromosome : Position : ID (NA) : REF Reference Nucleotide : ALT Alternative (variant) : QUAL Quality (Derived from PHRED) : FILTER (NA)

# Genotype region
vcf@gt[1:4, 1:3] # show data for sites 1 to 4, and show columns with format, and genotypes for individuals 1 and 2

##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">


# Check the DP field
# - DP = Read depth
dp <- extract.gt(vcf, element = "DP", as.numeric = TRUE)

# distribution of DP across sites for individual 2
hist(dp[,2], xlab="DP depth of coverage", main=colnames(dp)[2])
# plot boxplot distribution of DP across sites and individuals
boxplot(dp, ylim=c(0,100))

# plot the depth of coverage along the genome for individual 2
pos <- vcf@fix[,2] # the 2nd column of vcf@fix contains the position
plot(x=pos, y=dp[,2], col="blue", xlab="chromosome position", ylab="Depth of coverage")


# Get a matrix with the genotypes
# 1st. discard indels
vcf <- extract.indels(vcf, return.indels = FALSE)

# 2nd. get only SNPs with 2 alleles
# alternative allele can be used to detect multi-allelic sites
# we just want SNPs, so we keep only sites with 1 letter in alternative
alt <- vcf@fix[,5]
snp_sites_i <- which(alt=="A" | alt=="T" | alt=="C" | alt=="G")
vcf <- vcf[snp_sites_i,]
vcf

# 3rd. get only the genotype field (GT)
gt <- extract.gt(vcf, element="GT", as.numeric = FALSE)
str(gt)

# check how many genotypes of different types we have
table(gt)

# Genotypes are coded as 0|0, 0|1, 1|0 and 1|1
# we want to transform this into the values 0, 1, 1, 2
# as these correspond to
# homozygote for reference allele (0|0), 
# heterozygote, heterozygote (0|1) or (1|0),
# homozygote for alternative allele (1|1)

# replace elements of matrix 
gt[gt=="0|0"] <- 0
gt[gt=="0|1"] <- 1
gt[gt=="1|0"] <- 1
gt[gt=="1|1"] <- 2

# 4th - tranform into numeric (this is optional)
gt2 <- apply(gt, c(1,2), as.numeric)
str(gt2)

# 5th - save the file (here just saving 10 lines to save time)
write.table(gt[1:10,], file="test.geno", quote = FALSE, col.names = names(vcf@gt[1,-1]), row.names = FALSE)

# 6th - plot with genotypes
# here showing just first 1000 snps
nsites <- 1000
image(1:nrow(gt2[1:nsites,]), 1:ncol(gt2[1:nsites,]), gt2[1:nsites,],
      xlab="sites", ylab="individuals")
