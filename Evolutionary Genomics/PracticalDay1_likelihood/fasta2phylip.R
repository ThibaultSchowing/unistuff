library(ape)
#setwd("~/Downloads/switchdrive/phylogeny/MScBeFri/data")
d<-read.dna("data/clownfish_mtdna.fasta", format="fasta")
write.dna(d,"Clownfish_mtdna.phy", format="sequential", nbcol=10000, colsep="", colw=100000)
