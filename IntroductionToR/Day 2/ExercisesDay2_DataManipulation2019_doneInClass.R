# -------------------------------------------------------------------
# R course 2019
# Exercises day 2
# -------------------------------------------------------------------
getwd() # check the working directory

# Exercise 2.1 -------------------------------------------------------------------
# 
# Load data set from "StatWiSo2003.txt"
# 
#  - Use read.table(). 
#  - Determine the settings that should be used for 
#    the input arguments header, sep and na.strings. 
#  - What are the different settings doing? 
#  - Examine the first and the last few lines of the table
#  - Examine the first and the last few lines of the table
data <- read.table("StatWiSo2003.txt", 
           header=TRUE,
           na.strings="?", sep="\t")
data[1:3,] # print the first 5 lines
head(data)
tail(data)

# Exercise 2.2 -------------------------------------------------------------------
#
# Extract basic information about the data set 
# using the function str(), colnames(), ncol():
#  - What are the names of the columns?
#  - How many columns are there in total?
#  - What is the sample size?
#  - What are the data-types of the different measurements?
str(data)
colnames(data)


# Exercise 2.3 -------------------------------------------------------------------
#
# 2.3.1 Create a vector that contains the weight (Weight) of all students.
weight <- data$Weight # using the "$"
weight2 <- data[,6] # using the index of the column

# 2.3.2 Create another vector that contains the height (Height) of all students.
height <- data$Height
height2 <- data[,5] 

# 2.3.3 Combine the two vectors into a single matrix.
mat_wh <- cbind(weight, height) # using cbing
mat_wh2 <- matrix(c(weight, height), ncol=2) # using matrix
str(mat_wh)


# Exercise 2.4 -------------------------------------------------------------------
#
# Find out how many students don`t pay any 
# rent (MonthlyRent).
# Use logical operator "==".
sum(data$MonthlyRent == 0, na.rm=TRUE)


# using index 
index <- which(data$MonthlyRent == 0)
sum(index) # this will be wrong. 
           #Sum only works with vector of TRUE and FALSE
length(index) # the length of the vector index 
              # is the number of students that don't pay rent

# Just to check the first 5 students
data$MonthlyRent[1:5]
data$MonthlyRent[1:5] == 0
sum(data$MonthlyRent[1:5] == 0)
which(data$MonthlyRent[1:5] == 0)

# Exercise 2.5 -------------------------------------------------------------------
#
# Print to the screen What is the average rent among the students that pay rent?
# HINT: Use logical operators to find students that pay rent, 
#       and then use the function mean() to obtain 
#       the average rent of those that pay rent.


# Exercise 2.6 -------------------------------------------------------------------
#
# Using the matrix from exercise 2.3 
# a) remove the rows where the weight is smaller than 60 OR height is smaller than 165
#    HINTS: 
#    1. use logical operators ">", "<" 
#       create two vectors of True and False, one for each condition.
#    2. merge information from the two vectors, using logical operator OR "|"        
weight60 <- mat_wh[,1] < 60
height165 <- mat_wh[,2] < 165
weight60[1:10] | height165[1:10]


# b) remove all the rows where both weight and height are missing data
#    HINT: Use the function is.na() and the logical operator AND "&"


# Exercise 2.7 -------------------------------------------------------------------
#
# Split the matrix from exercise 2.3 into 
# two matrices: one for males and one for females.
# Use logical operator "==".



# Exercise 2.8 -------------------------------------------------------------------
#
# Sort the matrix from exercise 2.6a in ascending order, according to 
#   (i)  weight
#   (ii) height
# using the function order()

