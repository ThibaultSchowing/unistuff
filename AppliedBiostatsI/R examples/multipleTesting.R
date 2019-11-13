###########################################################
## Distribution of p-values under null hypothesis
set.seed(42)
t.val <- rt(10000, df = 12)
p.val <- pt(t.val, df = 12)
hist(p.val)

###########################################################
## Load p-values for data of Hedenfalk et al. (2001):
## Precalculated p-values corresponding to t-tests available
## in package "qvalue"

library(qvalue)
data(hedenfalk)
hedenfalk <- hedenfalk$p

# Number of values:
(m <- length(hedenfalk))

## Note: "hedenfalk" is a vector of 3170 p-values; each corresponds
## to one human gene and belongs to the null hypothesis: "the gene is
## not differentially expressed in carriers of a BRCA1 mutation and 
## carriers of a BRCA2 mutation"

###########################################################
## Control FPR: accept or reject null hypothesis based on raw
## p-values

# Show 20 smallest p-values
head(sort(hedenfalk), n = 20)
# Number of genes declared differentially expressed on 
# component-wise type I error rate (= significance level) of 1%:
sum(hedenfalk <= 0.01)

###########################################################
## Control FWER: accept or reject null hypothesis based on
## adjusted p-values (Bonferroni correction)

# Calculate adjusted p-values
p.adj.bonf <- pmin(1, hedenfalk*m)
# Already implemented in R:
p.adj.bonf2 <- p.adjust(hedenfalk, method = "bonferroni")
# Check values:
max(abs(p.adj.bonf - p.adj.bonf2))
# Show 20 smalles adjusted p-values
head(sort(p.adj.bonf2), n = 20)
# Number of genes declared differentially expressed on 
# experiment-wise type I error rate of 10%:
sum(p.adj.bonf <= 0.1)

###########################################################
## Control FWER: accept or reject null hypothesis based on
## adjusted p-values (Holm correction)

# Calculate adjusted p-values with predefined R method
p.adj.holm <- p.adjust(hedenfalk, method = "holm")
# Show 20 smallest adjusted p-values
head(sort(p.adj.holm), n = 20)
# Number of genes declared differentially expressed on 
# experiment-wise type I error rate of 10%:
sum(p.adj.holm <= 0.1)


###########################################################
## Control FDR: accept or reject null hypothesis based on
## q values (Benjamini-Hochberg correction)

# Calculate q-values with predefined R method
q <- p.adjust(hedenfalk, method = "fdr")
# Show 20 smallest q-values
head(sort(q), n = 20)
# Number of genes declared differentially expressed on 
# FDR of 5%:
sum(q <= 0.05)

