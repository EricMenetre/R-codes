To write efficient code, the following function returns an output like this one containing the date of the day  

```{r}
##-----------------------
##  vendredi 29.03.2019  
##-----------------------
```

You can then order your code by date of modification. 

Function : 

```{r}
date.banner <- function() {
  require("bannerCommenter")
  today <- format(Sys.Date(), format = "%A %d.%m.%Y")
  today <- as.character(today)
  open_box(today)
}
```

To call the function : 

```{r}
date.banner()
```
