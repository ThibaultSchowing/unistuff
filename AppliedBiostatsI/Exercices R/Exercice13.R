library(ggplot2)
library(plotly)

dbinom(3,50,0.1)
x <- seq(0,17,1)
y <- dbinom(x, 50, 0.1)



barplot(y)
barplot(y, names.arg = x)


df <- data.frame(x=x,prob=y)
head(df)
ggplot(data=df, aes(x=x,y=prob)) + geom_line() +
  geom_ribbon(data=subset(df,x>=5 & x<=20),aes(ymax=prob),ymin=0,
              fill="red", colour = NA, alpha = 0.5)

ggplot(data=df, aes(x=x,y=prob)) + geom_line() +
  geom_histogram()


g <- ggplot(df, aes(x=df$x., y=df$y)) +
  geom_point() + 
  labs(x = "Number of Minor value tubes", y = "Probability", title = "Probability Density Function")
g 



# COURS

x = rnorm(100,0,1)

hist (x, freq = F)

lines(density(x, bw=1), col = "red", lwd=2)

rug(x)
