import_epochs_.ep <- function(path, N_electrodes){
  
  require(readr)
  require(tidyr)
  files <- list.files(path)
  files_df <- data.frame(files)
  files_df$ep <- !grepl(".vrb", files_df$files)
  files_df <- files_df[files_df$ep == TRUE,]
  files_df$ep <- NULL
  subj <- list()
  col_TF <- N_electrodes + 1
  col_subj <- N_electrodes + 2
  for(i in 1:nrow(files_df)) {
    path_temp <- paste(path, "/", files_df$files[i], sep = "")
    subj[[i]] <- read_table2(file = path_temp, col_names = FALSE)
    subj[[i]][col_TF] <- 1:nrow(subj[[i]])
    subj[[i]][col_subj] <- paste("subj_",i,sep = "")
  }
   data <- do.call(rbind.data.frame, subj)
   data_groupped <<- data
}

import_epochs_.ep(path = "C:/Users/EricM/ownCloud/UNIGE/DOCTORAT/THESE/ETUDE 2_Stroop EEG lifespan/Analyses comportementales_PC_perso/study_2/EEG data/Moyennes/10-13/FW/Trigger 1/Export",N_electrodes =  128)

