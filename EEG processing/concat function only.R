# Function to concatenate a group of FW and BW EEG files. 
# I recommend to create a meta-data data frame containing the information needed in the function for
# each subject

concatenate_EEG <- function( path_FW, path_BW, name_subj, TF_del, path_save, ep_length){
  N_electrodes <- 128
  import_data <- function(path_list, FWBW, names, N_electrodes){
    require(readr)
    require(tidyr)
    data <- list()
    col_TF <- N_electrodes + 1
    col_subj <- N_electrodes + 2
    col_FWBW <- N_electrodes + 3
    for(i in 1:length(path_list)) {
      data[[i]] <- read_table2(file = path_list[i], col_names = FALSE)
      data[[i]][col_TF] <- 1:nrow(data[[i]])
      data[[i]][col_subj] <- names[i]
      data[[i]][col_FWBW] <- FWBW
    }
    subj <<- data
  } 
  
  # Import the FW and the BW  
  import_data(path_list = path_FW, FWBW = "FW",names =  name_subj, N_electrodes = N_electrodes)
  FW <- subj
  import_data(path_list = path_BW, FWBW = "BW",names =  name_subj, N_electrodes = N_electrodes)
  BW <- subj
  
  
  # delete the overlap --> Need to decide if the function needs the RT or the TF to delete
  subj_concat_full <- list()
  for (i in 1:length(FW)){
    if (TF_del[i] <= 0){
      subj_concat_full[[i]] <- rbind(FW[[i]], BW[[i]])
    } else {
      subj_concat_full[[i]] <- rbind(FW[[i]][1:(nrow(FW[[i]])-round((TF_del/2))),],
            BW[[i]][round((TF_del/2)):nrow(BW[[i]]),])
    }
  }
concatenation_data <<- subj_concat_full

  # save each element of the list in a folder

  for (i in 1:length(path_save)){
    write.table(subj_concat_full[[i]], path_save[i], row.names = FALSE, col.names = FALSE)
  }

}