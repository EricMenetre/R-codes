---
title: "TCD.table"
author: "Eric"
date: "23 mars 2019"
output: html_document
---

Simplified and modifiable function giving more informations than the summary one. 

Function : 

```{r}
TCD.table <- function(x){
  require("moments")
  sapply(x, function (x) { 
    c(mean = mean(x), sd = sd(x), median = median(x), min = min(x), max = max(x), kurtosis = kurtosis(x), skewness = skewness(x))
  })
}

```

definition of the dataframe df

```{r}
x <- rnorm(3, 0, 0.5)
y <- rnorm(3, 100, 3.25)
z <- rnorm(3, -10, 0.5)
a <- c("a", "b", "c")
df <- data.frame(x,y,z)

```

application : 

```{r}

TCD.table(df)

```

Be careful, it works only with numerical values !!!

if your dataframe contains character strings prefer this function : 

```{r}
TCD.table <- function(x){
  require("moments")
  
  for (i in x[,1:ncol(x)]) {
   if (is.character(i)){
     next
   } else if (is.numeric(i)) {
    return( c(mean = mean(i), sd = sd(i), median = median(i), min = min(i), max = max(i), kurtosis = kurtosis(i), skewness = skewness(i)))
    
  }

  }
}

```
New dataframe
```{r}
df2 <- data.frame(a,x,y,z)

```
And apply the function

```{r}
TCD.table(df2)
```


