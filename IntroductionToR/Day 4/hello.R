# Required R packages
# From Bioconductor
# DESeq2
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

# From CRAN
# Note that you can also use the install function in RStudio, instead of the commands below
install.packages("RColorBrewer")
install.packages("gplots")
