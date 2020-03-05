chr02<-read.dna("data/clownfish_chr02.fasta", format="fasta")
chr08<-read.dna("data/clownfish_chr08.fasta", format="fasta")
chr10<-read.dna("data/clownfish_chr10.fasta", format="fasta")
chr18<-read.dna("data/clownfish_chr18.fasta", format="fasta")
chr22<-read.dna("data/clownfish_chr22.fasta", format="fasta")
mtdna<-read.dna("data/clownfish_mtdna.fasta", format="fasta")
concat<-cbind(chr02,chr08,chr10,chr18,chr22,mtdna)
nbSites<-dim(concat)[2]
write.dna(concat, file="clownfish_concat.phy", format="sequential", nbcol=nbSites, colsep="")
