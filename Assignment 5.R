install.packages('tidyverse')
library(dplyr)
library(readr)
library(magrittr)
library(tidyverse)
library(ggplot2)





# Read the lines from the text file
raw_file <- readLines(con = "suites_dw_Table1.txt")


#Storing the descriptions in a different csv file 
raw_file[1:11] %>%
  writeLines('Variable_descriptions.csv')
  

raw_file %>% 
  .[-(14)] %>%                             # Removes the separator lines   
  .[-(1:12)] %>%                           # Removing the descriptions                                                 
  gsub(" ", "", .) %>%                     # Removing empty spaces
  gsub("\\|", ",", .) %>%                  # replacing vertical bars with commas
  writeLines('galaxy.csv')  



df <- read.csv('galaxy.csv')               #Loading the csv file as a new df

#Creating the plot
df %>% 
  ggplot(aes(x= log_lk, y = a_26)) +      #I choose to use log lk and a_26 as measurement for size
  geom_point() +                          
  scale_x_continuous(limits = c(0, NA))   #Changing the scale to show the tendancy 

#We see that the dataset does not contain a logarithmic stellar mass 
#under 3, potentially describing the tendancy that  
#smaller objects are underepresented in the dataset
