#
# R course
# Exercises day 1
# 

# clear environement variables
rm(list=ls())
getwd()
setwd("C:/Users/thsch/Desktop/introtoR/Day 1")

# Exercize 1.1 -------------------------------------------------------------------
# 
#  Create the following 3 vectors with the 
#  functions rep(), c() and special function ":"
#  
#  vec1 = 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
vec1 = rep(1:5, times=3)
#  vec2 = 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
vec2 = rep(1:5, each=3)
#  vec3 = 1 2 2 3 3 3 4 4 4 4 5 5 5 5 5
vec3 = rep(1:5, times=c(1:5))
# 
#  Check the help of functions rep() and c()
#  
#  While solving the exercise, answer the following questions:
#  - what is the input of the function rep()?
#  INPUT of rep() is a vector (x) and the arguments 
#           times (number or vector) or each (number or vector)
#  - what is the output of the function rep()?
#  OUTPUT of rep is a vector


# Exercize 1.2 -----------------------------------------------------------------
# 
# Create the following vectors with the function seq
# 
# vec5 = 0.0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
vec5 = seq(0, 5, by=0.5)
#
# - what is the input of the function seq()?
# INPUT: 3 numbers, from, to and by.
# - what is the output of the function seq()?
# OUTPUT: a vector.

# Exercize 1.3 -----------------------------------------------------------------
# 
#  Create the following vector with the function paste
#  
#  vec4 = "A1)" "A2)"  "A3)" "A4)" "A5)"
vec4 = paste("A", 1:5,")", sep="")
# - what is the input of the function paste()?
# INPUT of paste() are strings, vectors or numbers separated by a "," 
# - what is the output of the function paste()?
# OUTPUT of paste() is a string


# Exercize 1.4 -----------------------------------------------------------------
# 
# Replace all 1's by 0's in vec1, 
# using the logical operator "==",
# saving the results into a new vector.
newvector = replace(vec1, vec1==1, 0)

# Exercize 1.5 -----------------------------------------------------------------
# 
# Replace the 4th and 8th element of vec2 by -10,
# using indexes to access the elements of the vector vec2.
vec2[4] <- vec2[8] <- -10



# Exercize 1.6 -----------------------------------------------------------------
# 
# Suppress the 4th and 8th elements of vec2,
# using indexes to access the elements of the vector vec2.
vec2 <- vec2[-c(4,8)]


# Exercize 1.7 -----------------------------------------------------------------
# 
# Find the indices of the elements larger than 4 in vec3 
# using logical operator ">" and the function which()
which(vec3 > 3)


# Exercize 1.8 -----------------------------------------------------------------
# 
# Remove all the values 3 in vec3 using logical operator "=="
vec3 <- vec3[-which(vec3==3)]


# Exercize 1.9 -----------------------------------------------------------------
# 
# 1.9.1 Create the following matrix using 
#       the functions matrix(), c() and ":"
# 
# > m1
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9
# [4,]   10   11   12
m1 = matrix(c(1:12), nrow = 4, ncol = 3)


# 1.9.2 Add a column of zeros to the right 
#       using a vector and the function cbind()
m1 = cbind(m1, c(rep(0, ncol(m1))))

# 1.9.3 Add a line of zeros to the bottom 
#       using a vector and the function rbind()
m1 = rbind(m1, c(rep(0, nrow(m1))))
m1
# 1.9.4 Extract the 2nd line of m1 using 
#       indeces to access the elements of a matrix. 
m1[2,]

# 1.9.5 Extract the 3rd line of m1 using 
#       indeces to access the elements of a matrix,
#       and save it into a new matrix using "drop=F". 
newmatrix = m1[3, , drop=FALSE]

# 1.9.6 Rename the columns of the matrix m1 c1 to cn, 
#       where n is the number of columns of m1,
#       using the functions colnames(), paste() and ncol().
colnames(m1) <- paste("c",1:ncol(m1))

# 1.9.7 Rename the rows of the matrix m1 r1 to rn, 
#       where n is the number of rows of m1,
#       using the functions rownames(), paste() and nrow().
rownames(m1) <- paste("r",1:nrow(m1))
m1


