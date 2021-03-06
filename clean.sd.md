---
title: "Script cleaning Standard Deviation"
author: "Eric Ménétré"
date: "14 mai 2019"
output: html_document
---

The aim of this function is to clean data by removing the extreme values according to a deviation from the mean. usually, extreme values above 2 or 2.5 SD are removed from the analysis. Removing extreme values can be a very long and tedious job, and automation could be useful. The following function does it automatically for you. 

##Let us imagine the following dataframe:

Nottice that the data frame should be in a tidy format (i.e. at least a column for values and a groupping variable)

```{r}
library(reshape2)
data.test.1 <- rnorm(50, mean = 500, sd = 200)
data.test.2 <- rnorm(50, mean = 600, sd = 200)
data.test.3 <- rnorm(50, mean = 400, sd = 200)
data.test.4 <- rnorm(50, mean = 800, sd = 200)
data.test.5 <- rnorm(50, mean = 550, sd = 200)
data.test.6 <- rnorm(50, mean = 530, sd = 200)
df.test <- data.frame(data.test.1, data.test.2, data.test.3, data.test.4, data.test.5, data.test.6)
df.test.bon <- melt(df.test)
head(df.test.bon)
```

##Now execute the following function: 

```{r}
clean.sd <- function(df.var.val, df.var.group, n.sd, data, fill) {
  
  plot.before.cleaning <<- qqnorm(df.var.val, main = "Distribution before cleaning") ; qqline(df.var.val)
  hist.before.cleaning <<- hist(df.var.val, main = "Distribution of the RT before cleaning")
  
  # Creation of a dataframe with inferior and upper limits 
  moy.df.test <- data.frame(aggregate(df.var.val, list(df.var.group), mean, na.rm = TRUE))
  sd.df.test <- data.frame(aggregate(df.var.val, list(df.var.group), sd, na.rm = TRUE))
  lim.df.test <- moy.df.test
  lim.df.test$sd <- sd.df.test$x
  lim.df.test$lim.inf <- lim.df.test$x - (n.sd*lim.df.test$sd)
  lim.df.test$lim.sup <- lim.df.test$x + (n.sd*lim.df.test$sd)
  print("Means, standard deviations, inferior and superior limits of the data:")
  print(lim.df.test)
  
  # Data cleaning
  
  for (i in 1:nrow(lim.df.test)) {
    for (j in 1:nrow(data)) {
      if (is.na(df.var.val[j])) {
        next
      } else if (lim.df.test$Group.1[i] == df.var.group[j]) {
        if (df.var.val[j] <= lim.df.test$lim.inf[i]) {
          df.var.val[j] <- fill
        } else if (df.var.val[j] >= lim.df.test$lim.sup[i]) {
          df.var.val[j] <- fill
        }
      }
    }
  }
  
  clean.val <<- df.var.val
  
  # Verification
  # Definition of the number of values above or under the limit for the first subject
  
  sum.lim.sup <<- sum(df.var.val[df.var.val == lim.df.test$Group.1[1]] >= lim.df.test$lim.sup[1], na.rm = TRUE) + sum(df.var.val[df.var.val == lim.df.test$Group.1[2]] >= lim.df.test$lim.sup[2], na.rm = TRUE)
  sum.lim.inf <<- sum(df.var.val[df.var.val == lim.df.test$Group.1[1]] <= lim.df.test$lim.inf[1], na.rm = TRUE) + sum(df.var.val[df.var.val == lim.df.test$Group.1[2]] <= lim.df.test$lim.inf[2], na.rm = TRUE)
  sum.lim.tot <<- sum(sum.lim.sup, sum.lim.inf)
  
  if (sum.lim.tot == 0) {
    print("The job is done and work was verified for the first 2 groups")
  } else if (sum.lim.tot != 0) {
    print("WARNING: BE CAREFUL, SOME EXTREME VALUES REMAIN AT LEAST IN THE FIRST 2 GROUPS")
  }
  
  plot.after.cleaning <<- qqnorm(df.var.val, main = "Distribution after cleaning") ; qqline(df.var.val)
  hist.after.cleaning <<- hist(clean.val, main = "Distribution of the RT after cleaning")
  plot.before.cleaning
  hist.before.cleaning
  plot.after.cleaning
  hist.after.cleaning
  
  # Normality tests of Kolmogorov-Smirnov anf Shapiro Wilks 

  ks.before <- ks.test(df.var.val, "pnorm", mean = mean(df.var.val, na.rm = T), sd = sd(df.var.val, na.rm = T))
  ks.after <- ks.test(clean.val, "pnorm", mean = mean(df.var.val, na.rm = T), sd = sd(df.var.val, na.rm = T))
  ks.after$statistic
  # results of the normality tests
  
  print(paste("The Kolmogorov-Smirnov normality test D statistic before cleaning is", round(ks.before$statistic,2), "while the corresponding p-val equals", round(ks.before$p.value,2),". After cleaning, the D statistic is", round(ks.after$statistic,2), "and the corresponding p-val equals", round(ks.after$p.value,2)))
  
}
```

##This function does several operations : 

- It creates a table containing the mean value, the SD and the inferior and superior limits according to a certain number of SD above the mean (the number of standard deviation above the mean is customizable)
- It replaces the values either under the inferior limit or above the superior limit in a temporay vector that will be needed to be added to the original data frame. The replacement values can be defined in the function
- It verifies for the first two groups that none of the extreme values are still present in the output vector
- it creates two qqplots with the qqlines and two histograms to display the distribution before and after cleaning

##The arguments of the functions are: 

```{code}

clean.sd (df.var.val = , df.var.group = , n.sd = , data = , fill = )

```

- df.var.val = variable from the original data frame containing all the values
- df.var.group = variable from the original data frame containing all the names of the different condition needed to be cleaned separately
- n.sd = number of standard deviations above and under the mean needed to be removed
- data = name of the original data frame
- fill = value to replace the extreme values

## Example with the dataframe defined above: 

```{r}
clean.sd(df.var.val = df.test.bon$value, df.var.group = df.test.bon$variable, n.sd = 2, data = df.test.bon, fill = NA)
```

After execution of the function, sevral elements were created in the Global Environment. The most important output is the values called "clean.val"

Now to integrate this new vector to the original dataframe, use the following argument: 

```{r}
df.test.bon$clean.val <- clean.val
head(df.test.bon, 40)
```



## Summary

After executing the command, many things appear. In the plot window, two qqplots are now displayed (use the left arrow above the plot window to see the previous one). In the environement many variables were created and more importantly a vector containing all the cleaned values was created. In the console, a table containing the groups, mean, standard deviations and the inferior and superior limits used to mark rows as NA is displayed. The console should also return either the sentence : "The job is done and work was verified for the first 2 groups" or "WARNING: BE CAREFUL, SOME EXTREME VALUES REMAIN AT LEAST IN THE FIRST 2 GROUPS". If the second case appears, start crying or come to complain ;-). Finally, the cleaned values should appear in the console (twice...). 

If perhaps a cleaning according to different factors is needed (e.g. within the age groups and within the subjects), then run twice the function by changing the argument df.var.group.

There will probably be cases in which the function wil crash. In so, do not hesitate to come back to me for bug report and updates of the function. 


