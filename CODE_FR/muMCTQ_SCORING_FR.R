# MUNICH SCORING FOR THE FRENCH SAMPLE

# Useful Packages

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)

# import the dataset

library(readr)
S1_MCQT <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15096-16303_FR/S1_MCQT.csv")
View(S1_MCQT)

# shape

muMCTQ<- select(S1_MCQT, "Local Date", "Participant Private ID", "Question Key", "Response") %>%
  filter(grepl('response',x=`Question Key`))

# remove the HOUR from UTC and insert the name day

muMCTQ$`Local Date` <- substr(muMCTQ$`Local Date`, start = 0, stop = 10)
muMCTQ$`Local Date` <- weekdays(as.Date(muMCTQ$`Local Date`, tryFormats = c("%d/%m/%Y")))
muMCTQ <- rename(muMCTQ, "muMCTQ_day" = "Local Date")

# Rotate the dataset in order to have one line per participant

muMCTQ <- pivot_wider(muMCTQ, names_from =`Question Key`,values_from = "Response")

# remove the labelled one
# response 2, 1 = yes, 2 = no
muMCTQ <- select(muMCTQ, -"response-2")

# q.6 ON WORKDAYS I FELL ASLEEP AT

muMCTQ$response_6 <- paste(muMCTQ$`response-6-hour`, muMCTQ$`response-6-minute`, sep = ":")
muMCTQ<- select(muMCTQ, -"response-6-hour", -"response-6-minute")

# q.5 ON WORKDAYS I WAKE UP AT

muMCTQ$response_5 <- paste(muMCTQ$`response-5-hour`, muMCTQ$`response-5-minute`, sep = ":")
muMCTQ<- select(muMCTQ, -"response-5-hour", -"response-5-minute")

# q.7 ON DAY I DO NOT WORK I FELL ASLEEP AT

muMCTQ$response_7 <- paste(muMCTQ$`response-7-hour`, muMCTQ$`response-7-minute`, sep = ":")
muMCTQ<- select(muMCTQ, -"response-7-hour", -"response-7-minute")

# q.8 ON DAY I DO NOT WORK I WAKE UP AT

muMCTQ$response_8 <- paste(muMCTQ$`response-8-hour`, muMCTQ$`response-8-minute`, sep = ":")
muMCTQ<- select(muMCTQ, -"response-8-hour", -"response-8-minute")

# Renaming the variables
muMCTQ <- rename(muMCTQ, "muMCTQ_1"="response-2-quantised", "muMCTQ_2" = "response-3", "muMCTQ_3" = "response_6", "muMCTQ_4" = "response_5", "muMCTQ_5" = "response_7", "muMCTQ_6" = "response_8")

# Saving the dataset in csv

write_csv(muMCTQ, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/FR//muMCTQ_shaped_FR.csv")
