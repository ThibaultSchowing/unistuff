# Introduction to R statistics and analysis
# Clearing environement variables
rm(list=ls())

#Working directory (Day1)
getwd()

# vector have elements of the same type, it will coerce elements to the same higher type.
# access with simple []
vectorEx <- c(1:10)
vectorEx[1]

# A list is a generic vector containing other objects.
# access with double [[]]
listEx <- list(1, "a", vectorEx)
listEx[[3]]

# basic plot
plot(c(1:10), log10(1:10))

