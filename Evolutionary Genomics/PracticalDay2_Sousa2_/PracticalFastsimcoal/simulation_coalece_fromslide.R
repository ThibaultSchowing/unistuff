# From the slides - algorithme to simulate coalescence tree


N <- 1000
pcoal4 <- choose(4,2)*(1/(2*N))
pcoal3 <- choose(3,2)*(1/(2*N))
pcoal2 <- choose(2,2)*(1/(2*N))

# random sample time with 4 lineage

t4 <- rgeom(1, prob=pcoal4)
t3 <- rgeom(1, prob=pcoal3)
t2 <- rgeom(1, prob=pcoal2)


t4;t3;t2;

cumsum(c(t4,t3,t2))


# sample the topology / choose the pair that coalece

pair4 <- sample(1:4, size=2, replace=F)
pair4

pair3 <- sample(1:3, size=2, replace=F)
pair3




