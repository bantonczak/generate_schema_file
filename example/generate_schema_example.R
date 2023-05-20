#----------------------------------------------------------------~    

# This script provides an example of how to use an R function stored in a 
# separate R script to generate a schema information file (schema.ini) to be 
# used for importing a text file into ArcGIS software. 

# Schema.ini files help ensure that ArcGIS handles the information in the 
# delimited text files correctly (e.g., ensure the correct interpretation of  
# field types). Schema.ini files are particularly important for data with  
# fields containing leading zeros (e.g., GEOIDs).


# Date Created:        05/01/2023
# Date Last Modified:  05/01/2023
# Created by Brittany Antonczak
# University of Vermont, Burlington, VT
#----------------------------------------------------------------~ 


#  clear R environment

rm(list=ls()) 


#  install/load required packages 

if (!require("data.table")) install.packages("data.table")
if (!require("rstudioapi")) install.packages("rstudioapi")


# set working directory to source file location for portability of code

wd <- setwd(dirname(rstudioapi::getActiveDocumentContext()$path))  


# ----- LOAD FUNCTION ----- 

# source R function to generate schema.ini into current namespace

source(paste0(wd,"//dependencies/generate_schema_function.R"))


# ----- SET LOCAL VARIABLES ----- 

# set input directory path and csv file name with extension

in_dir = paste0(wd,"//input")
in_csv = "2020_acs5_us_county_median_hh_income.csv"


# set output directory path

out_dir = paste0(wd,"//output")


# --- LOAD DATA ----------------------------------------------------------

# check that input csv file and output directory exist

file.exists(paste0(in_dir,"//",in_csv), out_dir)


# load data

data <- data.table::fread(
  file = paste0(in_dir,"//",in_csv), header = TRUE, sep=",",
  # set GEOID field class as character to maintain any leading zeros
  colClasses = c("GEOID"="character")) 


# --- GENERATE SCHEMA.INI ------------------------------------------------

# generate schema.ini for loaded text file and store in output directory.

generate.schema.ini(data = data, file_name = in_csv, out_dir = out_dir)

# WARNING: The schema information file should always named Schema.ini and 
# should always stored in the same directory as the text data source. For the
# purposes of this example, the Schema.ini file will be stored in a separate 
# folder named 'output'.


# ----- END OF SCRIPT -----

