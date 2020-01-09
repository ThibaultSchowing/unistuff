#ex28
counts <- scan("counts.txt")
lambda0 <- mean(counts);lambda0

p.val <- 1 - ppois(counts - 1, lambda = lambda0)# lower tail
plot(1 -ppois(counts -1, lambda = lambda0))

which(p.val <= 0.05)

p.adj.bonf <- p.adjust(p.val, method = "bonferroni")
head(sort(p.adj.bonf))
which(p.adj.bonf <= 0.05)

p.adj.holm <- p.adjust(p.val, method = "holm")
head(sort(p.adj.holm))
which(p.adj.holm <= 0.05)

p.adj.fdr <- p.adjust(p.val, method = "fdr")
head(sort(p.adj.fdr))
which(p.adj.fdr <= 0.05)

plot(p.val, p.adj.bonf, pch = 0, xlab ="p-value", ylab="adjusted p-value")
points(p.val, p.adj.holm, pch = 3)
points(p.val, p.adj.fdr, pch = 4)
abline(h=0.05,col="red")