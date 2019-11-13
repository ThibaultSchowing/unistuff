# -------------------------------------------------------------------
# R course 2019
# Solutions for Exercises day 2
# -------------------------------------------------------------------

# Exercise 2.1 -------------------------------------------------------------------
# 
# Load data set from "StatWiSo2003.txt"
# 
#  - Use read.table(). 
#  - Determine the settings that should be used for 
#    the input arguments header, sep and na.strings. 
#  - What are the different settings doing? 
#  - Examine the first and the last few lines of the table
?read.table
ds <- read.table(file="StatWiSo2003.txt",
                 header=TRUE,
                 sep="\t",
                 na.strings = "?", stringsAsFactors=F)

# header = TRUE indicates that the first line in 
#          our data file are the names of the columns
# sep = "\t" specifies how entries are separated 
#       from each other, in our cas by a tab
# na.string = "?" specifies the string used for missing data, 
#             in our case it is a question mark

#  - Examine the first and the last few lines of the table
head(ds)
tail(ds)

# Exercise 2.2 -------------------------------------------------------------------
#
# Extract basic information about the data set 
# using the function str(), colnames(), ncol():
#  - What are the names of the columns?
#  - How many columns are there in total?
#  - What is the sample size?
#  - What are the data-types of the different measurements?
str(ds)
colnames(ds)
ncol(ds)
# 'data.frame':  263 obs. of  11 variables:
# $ Gender                : chr  "M" "M" "M" "M" ...
# $ Age                   : int  20 22 22 22 21 19 20 22 19 18 ...
# $ BirthMonth            : int  3 11 9 8 10 10 9 12 1 3 ...
# $ Canton                : chr  "Luzern" "Luzern" "Bern" "Aargau" ...
# $ Height                : num  176 169 178 170 164 165 164 165 165 NA ...
# $ Weight                : num  68 62 72 65 57 49 54 56 51 NA ...
# $ MonthlyRent           : num  454 550 0 665 0 0 400 700 0 0 ...
# $ Smoking               : int  0 2 0 2 0 0 0 1 0 0 ...
# $ RandomNumber          : int  5 8 8 6 6 4 1 7 2 5 ...
# $ NumberSiblings        : int  2 1 2 2 1 1 2 1 1 1 ...
# $ EstimatedTeacherHeight: int  179 179 180 176 178 180 178 175 178 180 ...

# Exercise 2.3 -------------------------------------------------------------------
#
# 2.3.1 Create a vector that contains the weight (Weight) of all students.
# 2.3.2 Create another vector that contains the height (Height) of all students.
# 2.3.3 Combine the two vectors into a single matrix.
ds$Weight
ds$Height
v_weight <- ds$Weight
v_height <- ds$Height
mat <- cbind(v_weight,v_height)
mat

# Exercise 2.4 -------------------------------------------------------------------
#
# Find out how many students don`t pay any rent (MonthlyRent).
# Use logical operator "==".
index.no.rent <- which(ds$MonthlyRent == 0)
length(index.no.rent)

#or
sum(ds$MonthlyRent == 0, na.rm=T)

# Exercise 2.5 -------------------------------------------------------------------
#
# What is the average rent among the students 
# that pay rent.
# Use logical operators to find students that pay rent, 
# and then use the function mean() to obtain 
# the average rent of those that pay rent.
vectorTrueFalse <- ds$MonthlyRent > 0
index_inds <- which(vectorTrueFalse)
rentOfThoseThatPayRent <- ds$MonthlyRent[index_inds]
mean(rentOfThoseThatPayRent)

# other solutions in a single line
mean(ds$MonthlyRent[ds$MonthlyRent > 0],na.rm = TRUE)

# using the function which() and indeces to access the elements
mean(ds$MonthlyRent[which(ds$MonthlyRent != 0)],na.rm = TRUE)
mean(ds$MonthlyRent[-which(ds$MonthlyRent==0)],na.rm = TRUE)

# Exercise 2.6 -------------------------------------------------------------------
#
# Using the matrix from exercise 2.3 
# a) remove the rows where the weight is smaller than 60 OR height is smaller than 165
#    HINTS: 
#    1. use logical operators ">", "<" 
#       create two vectors of True and False, one for each condition.
#    2. merge information from the two vectors, using logical operator OR "|"        
vectorTrueFalse <- mat[,1] > 60 | mat[,2] < 165 
index_rows_toremove <- which(vectorTrueFalse)
mat_condition <- mat[-index_rows_toremove,]

# b) remove all the rows where both weight and height are missing data
#    HINT: Use the function is.na() and the logical operator AND "&"
vectorTrueFalse <- is.na(mat[,1]) & is.na(mat[,2]) 
index_rows_toremove <- which(vectorTrueFalse)
mat_nomd <- mat[-index_rows_toremove,]


# Exercise 2.7 -------------------------------------------------------------------
#
# Split the matrix from exercise 2.3 into 
# two matrices: one for males and one for females.
# Use logical operator "==".
str(mat) # check the structure (str) of the variable
# get a vector of TRUE and FALSE, with TRUE for males, FALSE for females
vectorTrueFalse <- ds$Gender == "M" 
# get the index of rows for males 
index_row_males <- which(vectorTrueFalse) 
# get the matrix with males 
mat_males <- mat[index_row_males,]
# use the minus "-" to get all rows of matrix 
# except the ones in the index vector
mat_female <- mat[-index_row_males,] 


# Exercise 2.8 -------------------------------------------------------------------
#
# Sort the matrix from exercise 2.6a according to 
#   (i)  weight
#   (ii) height
# using the function order()
# order function gets as input a vector
# and it outputs the index of elements
index_sorted_inds <- order(mat_nomd[,1])
# the first element of index_sorted_inds is
# the lower value, the 2nd the next, and so on

# re-order all columns of the matrix 
# according to the index in index_sorted_inds  
mat_nomd_sorted <- mat_nomd[index_sorted_inds,]

