---
title: "clean.subj"
author: "Eric Ménétré"
date: "05/08/2019"
output: html_document
---

# Introduction

In the data cleaning process, we need to exclude values above and under a certain number of SD. However, we also need to exclude the subjects with an average value above a certain number of SD from the mean. To do so, usually, we (at least I ;)) estimated the mean of the group and compared the mean of the participant to an upper and inferior limit and rejected subjects out of the range. However, the subject we try to compare to the group is included to the group. The following functions removes the subject and estimate the mean of the group. Two functions were created in this purpose: the clean.subj and clean.subj.group functions.

## The first function: clean.subj 

The clean.subj function does textually what was described above. Execute the following code: 

```{r}
clean.subj <- function(group.var, subj.var, RT.var, N.sd, data){
  require("dplyr")
  
  # Not all datasets need to be specifically processed by group, the user should be able to chose. If it is not the case of your data frame, use the function clean.subj
  
  #dplyr specificity due to the NSE, need for enquo each variable and specify !! in the dplyr functions
  subj.var <- enquo(subj.var)
  RT.var <- enquo(RT.var)
  
  #creation of a data frame containing the age groups and the subjects names
  subj <- data%>%
    group_by(!!subj.var)%>%
    summarise()%>%
    rename(subject = !!subj.var)
  
  # Creation of a data frame containing the criteria according to which each subject will be compared
  criterion <<- data.frame(subj$subject)
  
  # Estimation of the upper and inferior limits for each subject inside each age group, excluding each subject one after the other
  for (i in 1:dim(subj)) {
    criterion[i,2:5] <<- data%>%
      filter(!!subj.var != subj$subject[i])%>%
      summarise(mean.grp = mean(!!RT.var, na.rm = T), sd = sd(!!RT.var, na.rm = T))%>%
      mutate(lim_inf = mean.grp-(N.sd*sd), lim_sup = mean.grp+(N.sd*sd))
  }
  
  # Estimation of the mean of each subject
  temp <- data%>%
    group_by(!!subj.var)%>%
    summarise(mean.subj = mean(!!RT.var, na.rm = T))
  
  criterion$mean.subj <<- temp$mean.subj
  
  # Comparing each subject to the criterion
  criterion$criterion <<- NA
  
  for (i in 1:dim(criterion)){
    if (criterion$mean.subj[i] >= criterion$lim_inf[i] & criterion$mean.subj[i] <= criterion$lim_sup[i]){
      criterion$criterion[i] <<- "kept"
    } else if (criterion$mean.subj[i] < criterion$lim_inf[i] | criterion$mean.subj[i] > criterion$lim_sup[i]) {
      criterion$criterion[i] <<- "OUT"
    }
  }
  
}
```

To use the function, here are the arguments: 

- subj.var: name of the variable of your dataframe containing the names of the subjects. Do not use quotes since the function uses dplyr. For example: subjects and not "subjects"
- RT.var: name of the variable containing the latencies or the values, usually the dependant variables of your data frame 
- N.sd: number of standard deviations above and under the mean, i.e. the criterion according to which you want to compare your subjects
- data: name of the dataframe

## The second function: clean.subj.group

Sometimes, especially in aging, developmental or lifespan studies, we need to perform exactly what does the previous function but for each age group separately for example (groups can be different from age, for example countries). This second function does exactly the same thing, except that the mean to which the subjects are compared is the mean of the sub-group and not the mean of the entire sample. The arguments of the function are identical except for one. First execute the following code if you want to use this function: 

```{r}
clean.subj.group <- function(group.var, subj.var, RT.var, N.sd, data){
  require("dplyr")
  
  # Not all datasets need to be specifically processed by group, the user should be able to chose. If it is not the case of your data frame, use the function clean.subj
  
  #dplyr specificity due to the NSE, need for enquo each variable and specify !! in the dplyr functions
  group.var <- enquo(group.var)
  subj.var <- enquo(subj.var)
  RT.var <- enquo(RT.var)
  
  #creation of a data frame containing the age groups and the subjects names
  subj <- data%>%
    group_by(!!group.var, !!subj.var)%>%
    summarise()%>%
    rename(group = !!group.var)%>%
    rename(subject = !!subj.var)
  
  # Creation of a data frame containing the criteria according to which each subject will be compared
  criterion <<- data.frame(subj$subject)
  
  # Estimation of the upper and inferior limits for each subject inside each age group, excluding each subject one after the other
  for (i in 1:dim(subj)) {
    criterion[i,2:5] <<- data%>%
      filter(!!group.var == subj$group[i])%>%
      filter(!!subj.var != subj$subject[i])%>%
      summarise(mean.grp = mean(!!RT.var, na.rm = T), sd = sd(!!RT.var, na.rm = T))%>%
      mutate(lim_inf = mean.grp-(N.sd*sd), lim_sup = mean.grp+(N.sd*sd))
  }
  
  # Estimation of the mean of each subject
  temp <- data%>%
    group_by(!!group.var, !!subj.var)%>%
    summarise(mean.subj = mean(!!RT.var, na.rm = T))
  
  criterion$mean.subj <<- temp$mean.subj
  
  # Comparing each subject to the criterion
  criterion$criterion <<- NA
  
  for (i in 1:dim(criterion)){
    if (criterion$mean.subj[i] >= criterion$lim_inf[i] & criterion$mean.subj[i] <= criterion$lim_sup[i]){
      criterion$criterion[i] <<- "kept"
    } else if (criterion$mean.subj[i] < criterion$lim_inf[i] | criterion$mean.subj[i] > criterion$lim_sup[i]) {
      criterion$criterion[i] <<- "OUT"
    }
  }
  
}
```

Arguments for this function are:

- *: the same as the clean.subj function
- group.var: refers to the name of the groupping variable. Be careful, use the name without quoting it. Example: age and not "age"


Have fun ;)



