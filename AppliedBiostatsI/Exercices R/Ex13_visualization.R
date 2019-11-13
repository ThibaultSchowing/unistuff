install.packages("ggplot2")

library("ggplot2")


## Exercise 13.a)
dbinom(3,50,0.1)


## Exercise 13.b)


dbinom(0,50,0.1) + dbinom(1,50,0.1) + dbinom (2, 50, 0.1) + dbinom(3,50,0.1)

pbinom(1,50,0.1)

## Visulaize 13.a)



dbin <- rbinom(1000, 50, 0.1)

id <- 1:1000

df_bin <- data.frame(x = id,
                     y = dbin)

dbin_x <- (dbinom(x = 0:50, size = 50, prob = 0.1))



barplot(dbin_x, width = 1, col = ifelse(0:51 == 3,"firebrick2", "grey75"),
        space = 0.5, ylab="Probability", xlab="", main = "P[X=3]")

barplot(dbin_x, width = 1, col = ifelse(0:51 == 0:3,"firebrick2", "grey75"),
        space = 0.5, ylab="Probability", xlab="", main = "P[X=3]")

### P[X=>3]

ggplot(data = NULL,
       aes(x = 0:50,
           y = dbin_x,)) +
  geom_bar(stat = "identity",
           fill = ifelse(0:50 == 3,"firebrick2", "grey25")) +
  theme_minimal() +
  scale_x_discrete(breaks = 0:50, labels = 0:50,
                   limits = c(0, 3, seq(10, 50, by = 10))) +
  xlab(label = "X") +
  ylab(label = "Density")

### P[X=>3]

ggplot(data = NULL,
       aes(x = 0:50,
           y = dbin_x,)) +
  geom_bar(stat = "identity",
           fill = ifelse(0:50 <= 3,"firebrick2", "grey25")) +
  theme_minimal() +
  scale_x_discrete(breaks = 0:50, labels = 0:50,
                   limits = c(0, 3, seq(10, 50, by = 10))) +
  xlab(label = "X") +
  ylab(label = "Density") +
  ggtitle(label = "[P≤3]")


