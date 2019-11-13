# -------------------------------------------------------------------
# R course 2019
# Exercises day 2
# -------------------------------------------------------------------
rm(list = ls())
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
df <- read.table("./StatWiSo2003.txt", header = TRUE, sep = '\t', na.strings = "?")

summary(df)
head(df)
tail(df)


# Exercise 2.2 -------------------------------------------------------------------
#
# Extract basic information about the data set 
# using the function str(), colnames(), ncol():
#  - What are the names of the columns?
#  - How many columns are there in total?
#  - What is the sample size?
#  - What are the data-types of the different measurements?
colnames(df)
dim(df)
summary(df)
str(df)
class(df)
attributes(df)
mode(df)


# Exercise 2.3 -------------------------------------------------------------------
#
# 2.3.1 Create a vector that contains the weight (Weight) of all students.
# 2.3.2 Create another vector that contains the height (Height) of all students.
# 2.3.3 Combine the two vectors into a single matrix.

vec1 <- df$Weight
length(vec1)
vec2 <- df$Height
length(vec2)

#m1 <- cbind(vec1, vec2) gives a list of two elements
m1 <- matrix(c(vec1, vec2), ncol = 2, nrow = length(vec1))
colnames(m1) = c("Weight", "Height")




# Exercise 2.4 -------------------------------------------------------------------
#
# Find out how many students don`t pay any rent (MonthlyRent).
# Use logical operator "==".

length(which(df$MonthlyRent == 0))


# Exercise 2.5 -------------------------------------------------------------------
#
# Print to the screen What is the average rent among the students that pay rent?
# HINT: Use logical operators to find students that pay rent, 
#       and then use the function mean() to obtain 
#       the average rent of those that pay rent.
mean(which(df$MonthlyRent != 0))


# Exercise 2.6 -------------------------------------------------------------------
#
# Using the matrix from exercise 2.3 
# a) remove the rows where the weight is smaller than 60 OR height is smaller than 165
#    HINTS: 
#    1. use logical operators ">", "<" 
#       create two vectors of True and False, one for each condition.
#    2. merge information from the two vectors, using logical operator OR "|"        

m2 <- m1[which(m1[,"Weight"] < 60 | m1[,"Height"] < 165), ]


# b) remove all the rows where both weight and height are missing data
#    HINT: Use the function is.na() and the logical operator AND "&"

m3 <- m1[which(!is.na(m1[,"Weight"]) & !is.na(m1[,"Height"])), ]

# Exercise 2.7 -------------------------------------------------------------------
#
# Split the matrix from exercise 2.3 into 
# two matrices: one for males and one for females.
# Use logical operator "==".

femalesIdx <- which(df$Gender == "W")
malesIdx <- which(df$Gender == "M")

m4females <- m1[femalesIdx, ]
m4males <- m1[malesIdx, ]


# Exercise 2.8 -------------------------------------------------------------------
#
# Sort the matrix from exercise 2.6a in ascending order, according to 
#   (i)  weight
#   (ii) height
# using the function order()

m2_order_w <- m2[order(m2[,"Weight"]), ]
m2_order_h <- m2[order(m2[,"Height"]), ]



