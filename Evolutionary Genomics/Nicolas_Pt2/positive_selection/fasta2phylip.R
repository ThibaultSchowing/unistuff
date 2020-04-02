library(ape)
#setwd("~/Downloads/switchdrive/phylogeny/MScBeFri/data")
d<-read.dna("_data/clownfish_rh1.fasta", format="fasta")
write.dna(d,"clownfish_rh1.phy", format="sequential", nbcol=10000, colsep="", colw=100000)
