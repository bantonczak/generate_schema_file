#----------------------------------------------------------------~    

# Function to generate a schema.ini file.


# Date Created:        05/01/2023
# Date Last Modified:  05/01/2023
# Created by Brittany Antonczak
# University of Vermont, Burlington, VT
#----------------------------------------------------------------~ 


# Description: 

# Function to generate a schema information file (schema.ini) for a single text 
# file. Prior to executing the function, the text file must be imported into R 
# as a data object. This function is limited to certain data types: Text, Long, 
# and Double.

# Schema.ini files help ensure that ArcGIS handles the information in the 
# delimited text files correctly (e.g., ensure the correct interpretation of  
# field types). Schema.ini files are particularly important for data with  
# fields containing leading zeros (e.g., GEOIDs).

# The schema information file should always named Schema.ini and 
# should always stored in the same directory as the text data source. 


# Arguments:

# data - Data object of text data source to be referenced in schema information 
#        file.
# file_name - (character) File name with file extension (e.g., .csv) of text 
#             data source.
# out_dir - (character) Directory path to store the output schema information 
#           file. This should be the folder as the text data source.

# Define Function:

generate.schema.ini <- function(data, file_name, out_dir){
  
  # install/load required packages 
  if(!require("stringr")) install.packages("stringr")
  
  # build schema information table
  schema_table <- data.frame(id = 1:length(names(data)), 
                             field_name = names(data), 
                             class = sapply(data, class), 
                             row.names = NULL) %>% 
    mutate(type = 
             case_when(class == "character" ~ "Text",
                       grepl("GEOID", field_name, ignore.case = TRUE) ~ "Text", 
                       grepl("FID", field_name, ignore.case = TRUE) ~ "Long",
                       TRUE ~ "Double")) %>%
    rowwise() %>%
    mutate(schema = paste0("Col",id,"=",field_name," ",type))
  
  # write schema information file to the defined output directory 
  writeLines(
    c(paste0("[",file_name,"]"),
      paste0(schema_table$schema)), 
    con = paste0(out_dir,"//Schema.ini")
  )
}


