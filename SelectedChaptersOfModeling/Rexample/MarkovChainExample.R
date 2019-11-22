# Example of markov chain application with a cool math-loving dude.

#install.packages("markovchain")
library(markovchain)

# we need to define the transition matrix

tm = matrix(c(0.6, 0.4, 0.0, 0.15, 0.65, 0.2, 0.1, 0.2, 0.7), nrow = 3, byrow = TRUE);tm

# now we need to create the markov chain

markov = new("markovchain", transitionMatrix = tm, states=c("No rain", "Light rain", "Heavy rain"), name="MarkovChain");markov

# Thaks to gigigigolo, speedygiorgio, whatever, we can plot it !
plot(markov)

library(ggplot2)

# Now we need an initial state: percentage of teritory in NR, LR and HR
initState = c(0.5, 0.4, 0.1)

# same as on theory,
initState %*% tm # %*% is for vector product

NR = c()
LR = c()
HR = c()

# we need a loop to see if we reach a steady state or not 
# -> see "Attractors and bassin" (maybe more for boolean transition matrix)

for(k in 1:50){
  nsteps = initState*markov^k
  
  NR[k] = nsteps[1,1]
  LR[k] = nsteps[1,2]
  HR[k] = nsteps[1,3]
  
  
  
}

# Transform the structur to dataframe

NR = as.data.frame(NR)
LR = as.data.frame(LR)
HR = as.data.frame(HR)

NR$Group = "No Rain"
NR$Iter = 1:50
names(NR)[1] = "Value"

LR$Group = "Light Rain"
LR$Iter = 1:50
names(LR)[1] = "Value"

HR$Group = "Heavy Rain"
HR$Iter = 1:50
names(HR)[1] = "Value"

# We need to bind the 3 independent vectors

steps = rbind(NR, LR, HR)

ggplot(steps, aes(x=Iter, y=Value, col=Group))+geom_line()+xlab("Chain Step")+ylab("Probability")+ggtitle("Markov chain")+theme(plot.title=element_text(hjust = 0.5))




























