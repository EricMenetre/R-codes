---
title: "Function to create TVAs for Cartool"
author: "Eric Ménétré"
date: "23 juillet 2019"
output: html_document
---

In Cartool, the TVA files are very useful to specify which epoch to keep or to reject. A TVA file should be a text document with the extension .tva. To create a TVA file, usually we open the main response Excel spreadsheet and isolate a subject, add a column with the RT, usually -100ms to avoid speech movements, and take only the accuracy of the response, the RT-100 and the trigger. This file should look like this, **but without the header**:

```{r echo=FALSE, message=FALSE, warning=FALSE}
library(knitr)
library(dplyr)
CR <- c(1,1,0,1,1,0,1,1,1,0)
RT <- round(rnorm(10, 700),2)
trig <- c(1,1,3,2,1,2,1,3,3,1)

data.frame(CR,RT, trig)%>% kable()

```

To avoid doing it manually, here is a function to create them automatically with R. 

First run the following code: 

```{r}
create.tva.files <- function(data, subj.var, CR.var, RT.var, trig.var, path.save) {
  require("dplyr")
  
#dplyr specificity due to the NSE, need for enquo each variable and specify !! in the dplyr functions
  subj.var <- enquo(subj.var)
  CR.var <- enquo(CR.var)
  RT.var <- enquo(RT.var)
  trig.var <- enquo(trig.var)
  
  # Creation of a table containing the name of each subject
  Sujets <- data%>%
    group_by(!! subj.var)%>%
    summarise(N = n())
  
  
  # Need to rename the first column consistantly to call it in the loop properly
  names(Sujets)[1] <- "Subjects"
    
  # Loop creating one TVA file per subject
   for (i in 1:dim(Sujets)) {
     data%>%
       filter(!!subj.var == Sujets$Subjects[i])%>%
       select(!!CR.var, !!RT.var, !!trig.var)%>%
       write.table(paste(path.save,"/", Sujets[i,1],"_TVA_in.tva", sep = ""),
                   sep="\t",
                   col.names = FALSE,
                   row.names = FALSE)
   }


}
```

The function has multiple arguments, which are:

                 
- *data*: is the name of the dataframe containing all the information of your experiment
-* subj.var*: is the name of the variable specifying to which subject the current row belongs
- *CR.var*: is the variable containing the the accuracy. This variable should be coded as 0 for wrong and 1 for correct. 
- *RT.var*: is the variable containing the RT of each trial for each subject. Be careful, the decimal marker should be a . and not a ,
- *trig.var*: contains the trigger number of each trial (usually the conditions)
- *path.save*: is the path were you want to save the file. use this formulation: "D:/menetre/Desktop/essai preprocessing Stroop/TVA" and do not put a / in the end, the function will do it for you

Here is an example of how to execute the function. Do not run this, the data frame is missing.

```{code}
create.tva.files(data = data_propres, 
                 subj.var = Sujet, 
                 CR.var = CR, 
                 RT.var = RTcNA_TVA, 
                 trig.var = Trig, 
                 path.save = "D:/menetre/Desktop/essai preprocessing Stroop/TVA"
                 )
```

After running the function, in the specify folder, you should find a TVA file for each of the subject containing three columns. The first one should be the accuracy of the response (or the information for Cartool to keep or not the epoch), the RT and the Triggers. 

Have fun !

