# SCORING FOR THE DEMOGRAPHICS OF THE DE VERSION

# USEFUL PACKAGES

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# importing the dataset:
library(readr)
S1_Demographics <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15575_DE/S1_Demographics.csv")


# # I took the variables of interest:

Demog_DE  <- select(S1_Demographics, "Local Date", "Participant Private ID", "Question Key", "Response")

# I removed the "Begin" and "End Questionnaire" rows

Demog_DE$`Question Key` <-   recode(Demog_DE$`Question Key`, "BEGIN QUESTIONNAIRE" = "R", "END QUESTIONNAIRE" = "R")
Demog_DE <- filter(Demog_DE, Demog_DE$`Question Key` != "R")

# Deleting the hour in Local date and inserting the day of the week
Demog_DE$`Local Date` <- substr(Demog_DE$`Local Date`, start = 0, stop = 10)
Demog_DE$`Local Date` <- weekdays(as.Date(Demog_DE$`Local Date`, tryFormats = c("%d/%m/%Y")))
Demog_DE <- rename(Demog_DE, "DEMOG_day" = "Local Date")

# rotating the dataset in order to have one line per participant 

Demog_DE <- pivot_wider(Demog_DE, names_from = "Question Key", values_from = "Response")

# i remove all the label variable keeping in mind that:


# SEX -> 1 = Male 2= Female ; Händigkeit (handedness) ->  1 = Righthanded, 2 = Lefthanded; 
# Family, Friends and Colleagues -> 1= Mai , 2= Mensilmente, 3=  Settimanalmente, 4=gironalemnte, 5= molte volte al giorno;
# drug -> 1 = no, 2 = yes; Covidsymptoms -> 1 = yes, 2 = no, Covid -> 1 = I think so, 2 = , 3 = I have been tested, 4 = None of the previous ones
#  Occupation -> 1 = student, 2 = worker, 3= non-worker (disoccupato) ; Homework -> 1 = yes, 2 = no


Demog_DE <- select(Demog_DE, -"Geschlecht", -"Händigkeit", -"Famile", -"Freunde", -"Kollegen", -"Drogen", -"COVID-19 Symptome", -"COVID-19")

# for what concerns Excitant quantised i recoded the variable in order to have 2 for yes and 1 for no since yes is signed with a missing value adn i removed the labelled one

Demog_DE$`Stimulanzien-quantised` <- replace_na(Demog_DE$`Stimulanzien-quantised`, 2)
Demog_DE <- select(Demog_DE, -"Stimulanzien")

# disorder is missing

# save the csv 

write_csv(Demog_DE, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/DE//Demographics_shaped_DE.CSV")
