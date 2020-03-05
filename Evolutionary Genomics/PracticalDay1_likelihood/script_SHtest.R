library(phangorn)
library(RColorBrewer)

setwd("C:/Users/thsch/Desktop/unistuff/Evolutionary Genomics/PracticalDay1/data")

dnaFiles<-system("ls Clownfish*.fasta", intern=T) #order: 16s (HKY85G), atp86 (GTRIG), bmp4 (HKY85G), cytb (F84IG), gylt (TN93G), rag1 (GTRG), zic1 (HKY85G)
dna<-lapply(dnaFiles, read.dna, format="fasta")

treeFiles<-system("ls Clownfish*phy_phyml_tree*.txt", intern=T) #order: 16s, all, atp86, bmp4, cytb, gylt, rag1, zic1
trees<-lapply(treeFiles, read.tree)

p<-list()
p[[1]]<-list(model="HKY", optInv=FALSE) #model for 16s
p[[2]]<-list(model="GTR", optInv=TRUE) #model for atp86
p[[3]]<-list(model="HKY", optInv=FALSE) #model for bmp4
p[[4]]<-list(model="HKY", optInv=TRUE) #model for cytb
p[[5]]<-list(model="TrN", optInv=FALSE) #model for gylt
p[[6]]<-list(model="GTR", optInv=FALSE) #model for rag1
p[[7]]<-list(model="HKY", optInv=FALSE) #model for zic1

res<-matrix(NA, nrow=length(trees), ncol=length(dna))
colnames(res)<-c("dna.16s","dna.atp86","dna.bmp4","dna.cytb","dna.gylt","dna.rag1","dna.zic1")
rownames(res)<-c("tree.16s","tree.atp86","tree.bmp4","tree.cytb","tree.gylt","tree.rag1","tree.zic1")

for(i in 1:length(dnaFiles)) {
  print("Testing file", dnaFiles[i],"\n")
  phylo.opt<-list()
  for(j in 1:length(treeFiles)) {
    print("Using tree", treeFiles[j],"\n")
    phylo<-pml(unroot(trees[[j]]), phyDat(dna[[i]]), model=p[[i]]$model, inv=0, k=4, shape=1)
    phylo.opt[[j]]<-optim.pml(phylo, model=p[[i]]$model, optInv=p[[i]]$optInv, optGamma=TRUE, optEdge=TRUE)
  }
  
  temp<-do.call(SH.test, phylo.opt)
  res[,i]<-temp[,4]
}

heatmap(res,scale="none",col=rev(brewer.pal(9,"Greens")))
