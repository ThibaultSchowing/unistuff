#######################################################################
# R COURSE University of Bern 2019
# Homework 2
#######################################################################

#######################################################################
# DEADLINE: Tuesday Oct 1, 2019
# Send R script with your solutions to your assigned TA.
# Check the file "TA_Allocation_ToStudents.xlsx" to find the e-mail address of your assigned TA.

#######################################################################
# In the SUBJECT of the e-mail type: R course 2019 homework 2
# The Rscript should be named [YourName]_Rcourse_homework2.r
# Replace [YourName] by your first and last name.
#######################################################################

# VERY IMPORTANT ######################################################
# You need to comment your code, such that it is clear you understand what you did.
# You get extra points if you produce plots that have the x and y axis labels, a main title, etc.
# You might contact your assigned TA if you have questions about the homework (not during the weekend).
########################################################################

#### -----------------------------------------------------------------------------------------------
# EXERCISE 1
# 1.1. Read the three files with the statistics from 
#      students from 2003, 2017 and 2018
#      from the files: "Student2003.txt", "Student2017.txt", "Student2018.csv"
#      save each file into a data.frame, 
#      such that you have three data.frames in memory.
#      NOTE: the separation of entrie and missing data characters are different for each file.
#            For "Student2003.txt" and "Students2018.csv" missing data is coded as "?"
#            For "Student2017.txt" missing data is coded as "NA".
#            The "Student2003.txt" and "Student2017.txt" are tab separated (sep="\t")
#            whereas "Students2018.csv" is separated by ";" (sep=";")

df2003 <- read.table("Student2003.txt", header=TRUE, sep="\t",na.string="?")
df2017 <- read.table("Student2017.txt", header=TRUE, sep="\t",na.strings="NA")
df2018 <- read.csv("Students2018.csv", header=TRUE, sep=";", na.strings = "?")

#Quick view of the structures with str(), head(), summary(), or whatever suits.
str(df2003)
str(df2017)
str(df2018)

# 1.2. Create a vector combining the heights (cm) of all years
# The vector contains NA's. It is possible to remove them and/or to use na.rm in min() or max()
heights <- c(df2003$Height, df2017$Height, df2018$Height)

# Removes NA's
heights <- heights[!is.na(heights)]
str(heights)

# 1.3. Save the minimum height across all years into a variable
# na.rm is useless here as NA's have been removed before, but we never know !
minHeight <- min(heights, na.rm = T)

# 1.4. Save the maximum height across all years into a variable
maxHeight <- max(heights, na.rm = T)

# 1.5. Save the mean of each year into a vector with three entries.
#      The 1st element of the vector correspond to the mean of the height of first file
#      The 2nd element of the vector correspond to the mean of the height of second file
#      The 3rd element of the vector correspond to the mean of the height of third file

meansHeight <- c(mean(df2003$Height, na.rm = T), mean(df2017$Height, na.rm = T), mean(df2018$Height, na.rm = T)); meansHeight

# 1.6. Write your own function to remove lines with missing data from a matrix with two columns.
#      INPUT of the function: matrix with two columns.
#      OUTPUT of the function: matrix with two columns without missing data.

# Works only with a matrix with two column -> returns false if input is different
removeLineWithNA <- function(mat){
  if (dim(mat)[2] != 2) {
    print("Matrix dimention not correct.")
    return(FALSE)
  }else{
    # Two column matrix with TRUE or FALSE for NA
    idxNA <- is.na(mat)
    # Save wether col 1, col 2 or both have a True in it. 
    idxLine <- idxNA[,1] | idxNA[,2] 
    # Returns a matrix with only lines without NA's
    return(mat[!idxLine,])
  }
  
}

#little test to verify
#m <- matrix(c(1,2,NA,4,5,NA,7,8,9,10), ncol = 2);m
#m_na <- removeLineWithNA(m);m_na

# 1.7. Create a matrix with two columns by extracting the columns with height and weight from "Student2003.txt"  
matHW2003 <- matrix(c(df2003$Height, df2003$Weight), ncol = 2);summary(matHW2003) # 5 + 12 NA's

# 1.8. Apply the function to remove missing data to the matrix with two columns created in 1.6.
matHW2003cleared <- removeLineWithNA(matHW2003); summary(matHW2003cleared) # no NA's


#### -----------------------------------------------------------------------------------------------
# EXERCISE 2
# 2. Compare the distribution of the height in the three years
#    by making three histograms next to each other in the same plot.
#    Use the layout() function to define the plot area.
#    Use the same x-axis scale for each histogram, and add the mean as a vertical line to each histogram.
#    Does it seem that students became taller or shorter over time?

def.par=par(no.readonly = T) #- saving default parameters before using layout()

# One line, 3 columns. Equivalent to par(mfrow=c(1,3))
layout(matrix(c(1,2,3), 1, 3))

hist(df2003$Height, xlim = c(150, 200), xlab = "Height [cm]", main = "Heights 2003")
abline(v=mean(df2003$Height, na.rm = T), lwd=2, col="red" )
hist(df2017$Height, xlim = c(150, 200), xlab = "Height [cm]", main = "Heights 2017")
abline(v=mean(df2017$Height, na.rm = T), lwd=2, col="red" )
hist(df2018$Height, xlim = c(150, 200), xlab = "Height [cm]", main = "Heights 2018")
abline(v=mean(df2018$Height, na.rm = T), lwd=2, col="red" )

# - They are just a bit shorter in 2017 but there's no big difference
# - Pay attention to the fact that the datasets are way smaller in 2017 and 2018
# - Confirm by looking at the means.

print(mean(df2003$Height, na.rm = T))
print(mean(df2017$Height, na.rm = T))
print(mean(df2018$Height, na.rm = T))

par(def.par) #- Restore default parameters after using layout()


#### -----------------------------------------------------------------------------------------------
# EXERCISE 3
# 3.1. Use a t.test() to test if the mean height of 2003 
#    is significantly different from the mean height in 2018.
#    Did the average height increased through time?

ttmean318H <- t.test(df2003$Height, df2018$Height)
# - The means are almost identical. p-value for the Ttest is 0.97: the diffenrences have 97% chance of being random. -> means are not significantly different

# 3.2. Use a t.test() to test if the means of the weigth of 2003
#    is significantly different from the weigth in 2018.
#    Did the average height increased through time?

ttmean318W <- t.test(df2003$Weight, df2018$Weight)
# - p-value is a bit higher but still nothing significant (0.282)


# 3.3. Provide answers as a comment in your script to the following questions
# 3.3.1. What is the null hypothesis? 
# - Null hypothesis:        There is no difference between the means of the two sample
# - Alternative hypothesis: The difference between the means is not equal to 0
# 3.3.2. What is the p-value? 
# - the p-value is the probability that the difference is due to randomness. In other words, the probability that the null hypothesis is true. 

# 3.3.3. Is there a significant difference between 2003 and 2018? 
# - No. 
# Answers to 3.3. should be short answers (1 line each answer).


#### -----------------------------------------------------------------------------------------------
# EXERCISE 4 
# 4.1. Make a function that, given the number "n" and a vector "weights",
#      samples randomly "n" entries from the vector "weights" 
#      and returns the mean weight of those sampled "n" individuals.
#      Tips: 
#      a) inside the definition of your function use the 
#         function sample() with replace=TRUE.
#      b) write down the variables that you need to give as 
#         INPUT to the function in the comments

# smpl
# Parameters: n: number of individuals to sample
#             w: matrix of weights 
#
# Return value: mean of the n sampled weight.
smpl <- function(n,w){
  w <- w[!is.na(w)]
  s <- sample(w, n, replace = TRUE)
  return(mean(s))
}

# 4.2. Call the function to get the mean of the height of a sample 
#      of 41 individuals (n=41), given as input the vector 
#      with the height from the Bern students dataset of year 2003.

mhsmpl2003 <- smpl(41,df2003$Height)

# 4.3. Use a for loop to call the function you did in 5.1. 1000 times, 
#      to compute the distribution of the mean of 41 individuals. 
#      This is done imagining that we were sampling individuals from 2003 
#      to create a sample with the same number of individuals as in 2018.
#      In other words, what would be the expected mean for 2018 
#      if we sampled 41 individuals from 2003. 
#      Note that 41 is the sample size in 2018. 
#      This is done by sampling a sample with the same number of students 
#      as in 2018 from the height distribution of students from 2003.
#      Save all the results into a vector with 1000 entries, 
#      each corresponding to the mean of each sample.

# Vector for sampled means
splmeans <- c()

for(i in 1:1000){
  m <- smpl(41,df2003$Height)
  splmeans <- c(splmeans, m)
}


# 4.4. Count the proportion of simulations larger than the observed mean of 2018.
#      Plot the histogram of the simulated (sampled) means.
#      Add a vertical line with the observed mean in 2018.
#      Based on this plot and the computed proportion, is there evidence of a significant  
#      change in the mean weight from 2003 to 2018 in the Bern students? 
#      What is the null hypothesis underlying this resampling procedure?

# Number of simulated obs > mean of 2018
nbGT2018 <- length(which(splmeans > mean(df2018$Height, na.rm = T)))
hist(splmeans, main="Sampled means", xlab="Height [cm]")
abline(v=mean(df2018$Height, na.rm = T), lwd=2, col="red")

# Just to try
abline(v=mean(splmeans), lwd=1, lty=2, col="blue")
legend("topright", 
       c("Mean 2018", "Mean sample"), 
       lty=c(1,2), 
       col=c("red","blue"), 
       bty = "n")

### -----------------------------------------------------------
# BONUS EXERCISE (not compulsory, but interesting if you want to get extra points)
# B.1. Make a linear regression of the weight against height
#      by pooling the data from the 3 years.

# create the data frame (vector -> matrix -> data frame)
data3y <- c(df2003$Height, df2017$Height, df2018$Height, df2003$Weight, df2017$Weight, df2018$Weight)
data3y <- as.data.frame(matrix(data3y, ncol=2))
colnames(data3y) = c("Height", "Weight")

# Linear regression
data3y.lm <- lm(data3y$Height~data3y$Weight)
dev.off()
plot(data3y)
#lines(faithful$eruptions, fitted(fit), col="blue")
lines(data3y$Height, fitted(data3y.lm), col="red")

# Answer the following questions as a comment in your script (1 line each answer)
# B.1.1. Is there a significant relationship between the two variables?
# B.1.2. What is the value of the slope? Is it significant?
# B.1.3. What is the value of the intercept? Is it significant?

# B.2. Make a plot with the regression line.
# note that for plot we need to put in the x axis the independent
# and in the y axis the dependent variable

# B.3. Do the residuals look normally distributed? 
# Perform qqplot analysis of the residuals


