
#### DEMOGRAPHIC SHAPING FOR TR FILES

# useful packages
library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)
library(eeptools)
library(na.tools)

# import the dataset

library(readr)
S1_Demographics <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_16144_TR/S1_Demographics.csv")
View(S1_Demographics)

# Shaping

Demographics <- select(S1_Demographics, "Local Date", "Participant Private ID", "Question Key", "Response")

# I removed the "Begin" and "End Questionnaire" rows
Demographics$`Question Key` <-   recode(Demographics$`Question Key`, "BEGIN QUESTIONNAIRE" = "R", "END QUESTIONNAIRE" = "R")
Demographics <- filter(Demographics, Demographics$`Question Key` != "R")

# Deleting the hour in Local date and transforming the day

Demographics$`Local Date` <- substr(Demographics$`Local Date`, start = 0, stop = 10)
Demographics$"Local Date" <- weekdays(as.Date(Demographics$`Local Date`, tryFormats = c("%d/%m/%Y")))
Demographics <- rename(Demographics, "DEMOG_Day" = "Local Date")

# we pivot the dataframe in order to have one line per participant:

Demographics <- pivot_wider(Demographics, names_from =`Question Key`,values_from = "Response")

# i remove all the label variable keeping in mind that:


# SEX -> 1 = Male 2= Female ; Handedness ->  1 = Righthanded, 2 = Lefthanded; 
# Family, Friends and Colleagues -> 1= Mai , 2= Mensilmente, 3=  Settimanalmente, 4=gironalemnte, 5= molte volte al giorno;
# drug -> 1 = no, 2 = yes; Covidsymptoms -> 1 = yes, 2 = no, Covid -> 1 = I think so, 2 = , 3 = I have been tested, 4 = None of the previous ones
#  Occupation -> 1 = student, 2 = worker, 3= non-worker (disoccupato) ; Homework -> 1 = yes, 2 = no


Demographics <- select(Demographics, -"sex", -"handedness", -"family", -"friends", -"colleagues", -"covidsymptoms", -"covid", - "Homework")

# insert the variable "Age" with age computed

Demographics$dob <- as.Date(Demographics$dob, format = "%d.%m.%Y")

# remove the missing values
Demographics <- Demographics[!is.na(Demographics$dob), ]

Demographics$Age <- age_calc(Demographics$dob, enddate = Sys.Date(), units="years", precise = FALSE)

# for what concerns Excitant quantised i recoded the variable in order to have 2 for yes and 1 for no since yes is signed with a missing value adn i removed the labelled one

Demographics$`excitant-quantised` <- replace_na(Demographics$`excitant-quantised`, 2)
Demographics <- select(Demographics, -"excitant")

# for what concerns disorder, since it is a rejection question, all the participant answered "no". i will delete the disorder columns

Demographics <- select(Demographics, -"disorder", -"disorder-quantised")

write_csv(Demographics,"/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/TR//DEMOG_SHAPED_TR.csv")
