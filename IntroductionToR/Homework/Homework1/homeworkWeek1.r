#######################################################################
# R COURSE University of Bern 2019
# Homework 1
# 
# DEADLINE: Monday Sept 23
# Send R script with your solutions to your assigned TA.
# Check the file "TA_Allocation_ToStudents.xlsx" 
# to find the e-mail address of your assigned TA.
#######################################################################

#######################################################################
# In the SUBJECT of the e-mail type: R course 2019 homework 1
# The Rscript should be named [YourName]_Rcourse_homework1.r
# Replace [YourName] by your first and last name.
#######################################################################

# VERY IMPORTANT ######################################################
# You need to comment your code, such that it is clear you understand what you did.
#######################################################################

# 1.0. Read the two files with the statistics from 
# students from 2003 and 2017 of the University of Bern
# from the files: "Student2003.txt", "Student2017.txt"
# Use the read.table functions with the following options
#   header=TRUE
#   na.strings="?"
#   sep="\t"


getwd()
# MODIFY according to your WD
setwd("C:/Users/thsch/Desktop/introtoR/Homework/Homework1")
df_2003 <- read.table("./Student2003.txt", header=TRUE, na.strings = "?", sep = '\t')
str(df_2003)
df_2017 <- read.table("./Student2017.txt", header=TRUE, na.strings = "?", sep = '\t')
str(df_2017)

# contains all data, including NA's

# 1.1 How many students were in the R course in the different years?
# See above: 
#   2003 -> 263 observations 
#   2017 -> 46 observations 
#
# Total: 309 observations with NA's -> 295 without NA's. (some have both Weight and Height missing)
# For 2003 here are the number of observation for Height and Weight (with and without omiting NA's): 
#> length(df_2003$Height)
#[1] 263
#> length(na.omit(df_2003$Height))
#[1] 258
#> length(df_2003$Weight)
#[1] 263
#> length(na.omit(df_2003$Weight))
#[1] 251

# 1.2. What variables did we measure in different years?
# print the column names into the screen for each file
print(colnames(df_2003))
print(colnames(df_2017))

#################################
### TOTAL question 1: 5 points
#################################

# 2.1. Create a vector combining the heights from the 2 years
combined_heights <- c(df_2003[,"Height"], df_2017[,"Height"])
length(combined_heights)

# 2.2. Create a vector combining the weights from the 2 years
combined_weights <- c(df_2003[,"Weight"], df_2017[,"Weight"])
length(combined_weights)

# 2.3. Create a matrix with the weight (1st column) and height (2nd column) of all years
# using the vectors defined in 2.1 and 2.2

# Here we still have some raws with NA's in weight or height... to ease next exercices, I removed them

mat_wh <- matrix(c(combined_weights,combined_heights), nrow = length(combined_heights), ncol = 2)
dim(mat_wh)
mat_wh <- na.omit(mat_wh)
dim(mat_wh)
#################################
### TOTAL question 2.1-2.3: 5 points
#################################

# 2.6. Plot the relationship between weight and height.
plot(mat_wh[,1], mat_wh[, 2], xlab = "Weight [kg]", ylab = "Height [cm]", main = "Relationship between weight and height")

# 2.7. Compute the mean height (2nd column) and save it into a variable
# Remove NA's with na.rm = TRUE because the mean function doesn't like NA's so much.
mean_height <- mean(mat_wh[,2], na.rm = TRUE)

#################################
### TOTAL question 2.6-2.7: 4 points
#################################

# 2.8. Add blue points to the plot for individuals with height
# between [mean-5cm, mean+5cm]
# Follow the steps below:
# a) use logical operators, save it into a vector of TRUE and FALSE
cond_height <- (mat_wh[,2] > mean_height - 5 & mat_wh[,2] < mean_height + 5)
# b) from the vector of True and False use the function which to find the index of rows. 
#    Save it into a variable called vectorIndex
vectorIndex <- which(cond_height)
# c) add blue points to the plot for only the selected rows.
points(mat_wh[vectorIndex,], col = "Blue")


#################################
### TOTAL question 2.8: 4 points
#################################

# 2.9. Have a look at the following command line.
# Answer the following questions as a comment in your script:
# a) how many functions can you find (do not count logical operations)?
# - Plot(), c(), min(), max(), paste() and Length() -> 6 functions
# b) how many logical operations are performed?
# - height < 60 -> 1 logical operation
# c) how many variables are used?
# - height and weight are the only variables used in here.
# d) what are the arguments we give as input to function plot()?
# - x, y, xlim, max, main. To know what they are, type ?plot.

# juste setting the variables with these names. NA's need to be ignored in min and max
# also, I modified the logical condition because you compared "height" instead of "weight"

weight <- mat_wh[,1]
height <- mat_wh[,2]
plot(x=height, y=weight, xlim=c(min(height), max(height)), main=paste("There are ", length(which(weight<60)), " people < 60Kg"))


#################################
### TOTAL question 2.9: 2 points
#################################

