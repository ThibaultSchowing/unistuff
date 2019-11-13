# Cancer Genomics Week 2

library(DESeq2)
# The next two packages are used for plotting heatmaps
library(RColorBrewer)
library(gplots)

#Prepare the data for analysis
#Step 1: Read in data table, so that it contains the Geneid as rownames and only the counts as columns.

countData<-read.table('breastCancer.counts.forDESeq.txt', header=TRUE, row.names = T)

sampleGroup<-sub(".$", "", colnames(countData)) # remove the last character (= replicate number) from the sample name to end up with subtype

#Step 2: Create a data frame containing the experimental group of each sample
colData<-data.frame(condition=factor(sampleGroup))

#Step 3: Create the DESeqDataSet object
dds<-DESeqDataSetFromMatrix(countData, colData, formula(~condition))

# Perform the differential expression analysis and extract the results
dds<-DESeq(dds, betaPrior = TRUE)
res <-results(dds)

# Visualize results
# Plot 1: PCA using the 500 most variably expressed genes

rld <-rlog(dds, blind=TRUE) # apply a regularized log transformation, ignoring information about experimental groups
p<-plotPCA(rld, intgroup=c("condition"))
print(p, ntop=500)


# Plot 2: Mean expression against log-fold change. Genes with p-adjusted below alpha will be shown in red, all others in grey

plotMA(res, alpha=0.05)

# Plot 3: Heatmap using the 50 most highly expressed genes

select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:50]

hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)

heatmap.2(assay(rld)[select,], 
          col = hmcol, 
          trace="none", 
          margin=c(10,6),
          labCol=colnames(dds), 
          cexRow = 1/log10(length(select)))

# Optional task: Try to recreate the VOLCANO PLOT from the lecture slides

#convert res to a dataframe and remove all genes that don't have an adjusted p-value
res_volcano <- as.data.frame(res)
res_volcano <- res_volcano[!is.na(res_volcano$padj),]


## with ggplot2
library(ggplot2)
g=ggplot(data=res_volcano, aes(x=log2FoldChange, y=-log10(pvalue), colour=as.factor(padj<0.05))) + geom_point()
g

## with base plotting function
plot(res_volcano$log2FoldChange, -log10(res_volcano$pvalue), pch=16, col=as.factor(res_volcano$padj<0.05))

# Pairwise contrasts
# Now take a closer look at the results and the normalised count data:

head(res)
head(counts(dds, normalized=TRUE))

# The log2FoldChange is approximately the mean of the normalised counts for condition 1 over the mean of the normalised counts for conditions 2 (“approximately”, because of the shrinkage explained in the lecture)

# In our dataset, we have more than 2 groups, i.e. our factor “condition” has more than 2 levels. In this situation, DESeq2 by default outputs a comparison of the last level of the factor over the first level (in alphabetical order), in our case TNBC vs HER2 (see “Note on factor levels” in DESeq2 vignette)

# We can explicitly specify which levels we want to compare, as follows:

TNBC_HER2 <-results(dds, contrast=c('condition', 'TNBC', 'HER2' ))

# Let’s double-check that this really produces exactly the same results as before by comparing the log2 fold changes:

plot(res$log2FoldChange, TNBC_HER2$log2FoldChange, xlab='first analysis', ylab='second analysis')

# TODO Extra task
# Extra task: Perform some of the other pairwise comparisons that are possible for this dataset

# Export the results to a tab-delimited file
# Our variable ‘res’ contains only the results from the test for differential expression. Before we export this as a table, we add the original counts for each gene in each sample. We then export the original table and a table sorted by adjusted P-values


combined <- cbind(counts(dds), as.data.frame(res)) # This assumes that the genes are in the same order in both tables!
# alteratively, we could use the normalised counts by using counts(dds, normalized=TRUE)
write.table(combined, 'MyResults.txt', quote=FALSE, row.names=TRUE, sep='\t')
write.table(combined[order(combined$padj),], 'MyResults_sorted.txt', quote=FALSE, row.names=TRUE, sep='\t')










