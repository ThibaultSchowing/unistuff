# load functions defined in "coalfunctions.r" that will be used to simulate and plot coalescent trees
source("coalfunctions.r")

# call sim.tree() function to simulate gene trees

## In this example, the population size is 1000
# INPUT OF sim.tree() function
# sample - how many gene copies (lineages) are sampled?
# current - what is the current effective size (in number of haploid gene copies)?
# ancestral - what is the ancestral effective size (in number of haploid gene copies)?
# time - how long ago did the size changed from ancestral to current?
# nrep - how many loci?  
nloci <- 10 # number of loci
nind <- 2 # number of individuals
# simulate a tree with function sim.tree()
tree <- sim.tree(sample = 2*nind, current = 1000, ancestral=1000, time=0, nrep=nloci)

## The function draw.tree() plots (on the screen) the coalescent tree
## the nrep is the number of trees simulated.
draw.tree(tree, nrep=nloci)

## You can get the coalescent time intervals with
## the function coaltimes()
## the nrep is the number of trees simulated.
coal <- coaltimes(tree, nrep=nloci)

# the output is a matrix where row is the coalescent interval
# and each column is a tree. The 1st column has the number of lineages in each interval.

# To get the time in generations, you need to multiply by 4Ne
coal[,-1]*4*1000 