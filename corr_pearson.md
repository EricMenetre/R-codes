
# How to obtain correlation values from two vectors with a p-values

In R, there are many ways to perform a correlation. The cor() function can be used as well as the rcorr() function from the Hmisc pkg. Nevertheless, the cor() function does not provide p-values and the rcorr() function works only on matrices. It would convenient to have a correlation function working between two vectors and giving back a p-value. That is the reason why I wrote the cor_pearson() function. Here is a new homemade function to fill the gap. 

First, run the following function: 

```{r}

cor_pearson <- function(x,y,data){
  mean.x <- mean(x, na.rm = T)
  mean.y <- mean(y, na.rm = T)
  n = nrow(data)
  sd.x <- sd(x, na.rm = T)
  sd.y <- sd(y, na.rm = T)
  
  roh.x <<- NA
  roh.y <<- NA
  
  for (i in 1:n){
    if(is.na(x[i]) | is.na(y[i])){
      next
    } else {
    roh.x[i] <<- x[i]-mean.x
    roh.y[i] <<- y[i]-mean.y
    }
  }

  sum.roh.x <- sum(data$roh.x, na.rm = T)
  sum.roh.y <- sum(data$roh.y, na.rm = T)

  roh <- (sum.roh.x*sum.roh.y)/(n-1)*sd.x*sd.y
  
  t.val <- roh * sqrt((n-2)/(1-(roh*roh)))
  
  t.distr <- seq(from = -5, to = 5, by = 0.01)
  density <- dt(t.distr, (nrow(data)-1))
  
  t.plot <- data.frame(t.distr, density)
  
  p.val <- t.plot$density[t.plot$t.distr == round(t.val, 5)]

  print(paste("Pearson's r value:", roh))
  print(paste("t value:", t.val))
  print(paste("p-val is:", round(p.val,6)))

}

```


The function takes three arguments: 

- x: the first vector e.g. data$vector1
- y: the second vector e.g. data$vector2
- data: name of the dataframe e.g. data

Use the function as follow: 

```{r}
corr_pearson(x,y,data)

```

