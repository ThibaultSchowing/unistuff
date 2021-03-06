library(ape)
library(phangorn)

dna <- read.dna(file="data/clownfish_mtdna.fasta", format="fasta")
dna <- read.dna(file="data/clownfish_chr02.fasta", format="fasta")
dna <- read.dna(file="data/clownfish_chr08.fasta", format="fasta")
dna <- read.dna(file="data/clownfish_chr10.fasta", format="fasta")
dna <- read.dna(file="data/clownfish_chr18.fasta", format="fasta")
dna <- read.dna(file="data/clownfish_chr22.fasta", format="fasta")

#setwd("~/UNIFR/2_semester/Evolutionnary_genomics/27.02/MScBeFri/data/trees")
#setwd("C:/Users/thsch/Desktop/unistuff/Evolutionary Genomics/PracticalDay1")


chr2 <- read.tree(file="tree/clownfish_chr02-PhyML_tree")
chr8 <- read.tree(file="tree/clownfish_chr08-PhyML_tree")
chr10 <- read.tree(file="tree/clownfish_chr10-PhyML_tree")
chr18 <- read.tree(file="tree/clownfish_chr18-PhyML_tree")
chr22 <- read.tree(file="tree/clownfish_chr22-PhyML_tree")
mt <- read.tree(file="tree/clownfish_mtdna-PhyML_tree")
                   
phylo1 <- pml(unroot(chr2), phyDat(dna), model="GTR", k=4, inv=0)
phylo1.opt <- optim.pml(phylo1, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)
phylo2 <- pml(unroot(chr8), phyDat(dna), model="GTR", k=4, inv=0)
phylo2.opt <- optim.pml(phylo2, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)
phylo3 <- pml(unroot(chr10), phyDat(dna), model="GTR", k=4, inv=0)
phylo3.opt <- optim.pml(phylo3, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)
phylo4 <- pml(unroot(chr18), phyDat(dna), model="GTR", k=4, inv=0)
phylo4.opt <- optim.pml(phylo4, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)
phylo5 <- pml(unroot(chr22), phyDat(dna), model="GTR", k=4, inv=0)
phylo5.opt <- optim.pml(phylo5, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)
phylo6 <- pml(unroot(mt), phyDat(dna), model="GTR", k=4, inv=0)
phylo6.opt <- optim.pml(phylo6, optQ=TRUE, optBf = TRUE, optEdge=TRUE, optInv=TRUE, optGamma=TRUE)

SH.test(phylo1.opt, phylo2.opt, phylo3.opt, phylo4.opt, phylo5.opt, phylo6.opt)
