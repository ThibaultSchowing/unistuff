library(ape)
# run phyml sequentially on each DNA model
#change the execname based on what you have on your computer
phyml.test<-phymltest(seqfile="clownfish_chr10.phy", execname="PhyML_3.0/phyml_3.0_win32.exe -b 0 -o lr", append = FALSE, "sequential")
#takes a while...
#plot the results
plot(phyml.test)

# Save an object to a file
saveRDS(phyml.test, file = "model_compare_chr10.rds")
# Restore the object
readRDS(file = "model_compare_chr10.rds")

