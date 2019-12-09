# Function to create the .tva files
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