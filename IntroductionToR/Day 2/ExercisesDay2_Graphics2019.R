# -------------------------------------------------------------------
# R course 2019
# Exercises day 2 - Graphics
# -------------------------------------------------------------------
rm(list = ls())
# Exercise 2.9 --------------------------------------------------------------------
#
# Load the StatWiSo2003 data set using the function read.table().
#
# 2.9.1 Plot the distribution of the random numbers (RandomNumber) in a suitable way.
#       What is the best way to represent this variable? 
#    - A scatterplot with plot() function? 
#    - An histogram with hist() function? 
#    - A boxplot with boxplot() function? 
#    - A barplot with barplot() function?
#       Use these different functions.
#       What can you learn from the different plots?
df <- read.table("./StatWiSo2003.txt", header = TRUE, sep = '\t', na.strings = "?")

plot(df$RandomNumber)
boxplot(df$RandomNumber)
barplot(df$RandomNumber)
hist(df$RandomNumber)


# 2.9.2 Make two graphs of the random numbers ("RandomNumber" column),
#       distinguishing between males and females.
#       Use the following layout() function to add the two graphs 
#       next to each other in the same plot.
#
#           layout(matrix(c(1:2),nrow=1)); layout.show(2)
#       What are the arguments of the layout() function?
#       
#       After plotting the data, is there a difference between males and females?

layout(matrix(c(1:2),nrow=1)); layout.show(2)

femalesIdx <- which(df$Gender == "W")
malesIdx <- which(df$Gender == "M")

plotFemale <- boxplot(df[femalesIdx,"RandomNumber"])
plotMale <- boxplot(df[malesIdx,"RandomNumber"])



# 2.9.3 Plot the weight (dependent variable) against 
#       height (independent variable). What do you see from that plot? 
#       Is the pattern the same if we consider males and females separatly?
#Quick results

plot(df$Weight, df$Height)

plot(df[femalesIdx, "Weight"], df[femalesIdx, "Height"])
plot(df[malesIdx, "Weight"], df[malesIdx, "Height"])



# 2.9.5. Improve the graph from 2.9.3 by:
#        - removing lines with missing data to have a clean data set, using is.na() function.
#        - color the points by gender, using logical operator "=="
#        HINT: create a vector with color names, with "color1" for women and "color2" for men.
#              Use color names from RColorBrewer "http://colorbrewer2.org/#type=qualitative&scheme=Dark2&n=3"
#              Choose colors for "qualitative" data, using colorBlind safe colors. 
#              For instance, using "#1b9e77" for women and "#d95f02" for men.
#              Use that vector of color names (with the same size as the number of points) 
#              as input for the argument "col=" of function plot()

df_full <- na.omit(df)
idf = which(df_full$Gender == "W")
idm = which(df_full$Gender == "M")
vec_colors <- c(rep("Blue", length(df_full$Gender)))
vec_colors[idf] = "Red"

dev.off()


plot(df_full$Weight, df_full$Height, col=vec_colors)


# 2.9.5 Make a plot that shows whether 50% of all students pay less or 
#       more than 500 Fr monthly rent (MonMiete) 
#       (excluding the ones that pay no rent)

df_rent <- df[which(df$MonthlyRent > 0),]

boxplot(df_rent$MonthlyRent)
abline(h = 500, col = "red")

# Exercise 2.10 -------------------------------------------------------------------
# 
# Make an histogram of 100 values sampled from a normal distribution with mean 170 and variance 20
# Use the function rnorm() to sample values from a normal distribution.
#
# 2.10.1 Add the label "frequency" to the y-axis of the plot
# 2.10.2 Add a title to the plot, e.g., 
#        Histogram of samples drawn from a Normal Distribution"
# 2.10.3 Manually set the range of the axes: 100 to 230 for x-axis, 
#        0 to 0.04 for y-axis
# 2.10.4 Use the function rug() to add the data points.
# 2.10.5 Repeat the same exercise, but with a sample of 20 values.

layout(matrix(c(1:2),nrow=1));
# WTF with the y limit ?! (doesn't show anything cuz it's too low.)
x <- rnorm(100, 170, 20)
hist(x, ylab = "frequency", main = "Histogram of sample drawn from a Normal Distribution", xlim = c(100,230))
rug(x)

x <- rnorm(20, 170, 20)
hist(x, ylab = "frequency", main = "Histogram of sample drawn from a Normal Distribution", xlim = c(100,230))
rug(x)

par(mfrow=c(1,1))
