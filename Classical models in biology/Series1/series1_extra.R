rm(list=ls())

# Discret time logistic (Verhulst) model
######################################################

r <- 2.4 #per capita growth rate (or intrinsic growth rate)
K <- 1
delta_t <- 1 #time step
N0 <- 0.1 #initial condition


time_steps <- seq(0,100,by=delta_t) #sequence of time steps
N <- rep(NA,length(time_steps)) #creat a list to store the solution
N[1] <- N0 #set the first step as the initial condition

#Euler's solver
for (i in 2:length(time_steps)){
  N[i] <- N[i-1] + N[i-1] * r * ( 1  -  N[i-1] / K ) * delta_t
}

#plot the solution
plot(time_steps,N)

#what is going on in this model, why this is not converging to K?
#what happens with r = 1, and with r = 3?
