
#### PSQI (MONTHLY) SHAPING 

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)


# Importing the dataset:

library(readr)
S1_PSQI <- read_csv("Desktop/data_exp_16095_IT/S1_PSQI.csv")
View(S1_PSQI)


# Shaping the Dataset:

PSQI<- select(S1_PSQI,"Local Date", `Participant Private ID`,`Schedule ID`,
              `Question Key`, Response) %>%
  filter(grepl('PSQI',x=`Question Key`))

# Fixing the date and changing with the day name

PSQI$`Local Date` <- substr(PSQI$`Local Date`, start = 0, stop = 10)
PSQI$"Local Date" <- weekdays(as.Date(PSQI$`Local Date`, tryFormats = c("%d/%m/%Y")))
PSQI<- rename(PSQI, "PSQI_M_DAY" = "Local Date")


# pivot

PSQI <- pivot_wider(PSQI, names_from = "Question Key", values_from = "Response")

# PSQI 1 IN MEDIA A CHE ORA SEI ANDATO A LETTO

PSQI$PSQI_1 <- paste(PSQI$`PSQI_1-hour`, PSQI$`PSQI_1-minute`, sep = ":")
PSQI <- select(PSQI, -"PSQI_1-hour", -"PSQI_1-minute")

# PSQI 3 IN MEDIA A CHE ORA TI SEI SVEGLIATO

PSQI$PSQI_3 <- paste(PSQI$`PSQI_3-hour`, PSQI$`PSQI_3-minute`, sep = ":")
PSQI <- select(PSQI, -"PSQI_3-hour", -"PSQI_3-minute")

# PSQI 4 in media quante ore  hai domrito

PSQI$PSQI_4 <- paste(PSQI$`PSQI_4-hour`, PSQI$`PSQI_4-minute`, sep = ".")
PSQI <- select(PSQI, -"PSQI_4-hour", -"PSQI_4-minute")

# ODERING AND NOT INCLUDING THE USELESS VARIABLES
colnames(PSQI)         

PSQI <- PSQI[, c(1,2,3,47,4,5, 48,49,7,9,11,13,15,17,19,21,23,24,25,26,28,30,32,34,36)]

# Renaming the variables in order to make them function in the script for the scoring

PSQI <- rename(PSQI, "Sleep1" = "PSQI_1", "Sleep2" = "PSQI_2-minute", "Sleep3" = "PSQI_3", "Sleep4" = "PSQI_4", "Sleep5a" = "PSQI_5a-quantised",
               "Sleep5b" = "PSQI_5b-quantised", "Sleep5c" = "PSQI_5c-quantised", "Sleep5d" = "PSQI_5d-quantised", "Sleep5e" = "PSQI_5e-quantised",
               "Sleep5f" = "PSQI_5f-quantised", "Sleep5g" = "PSQI_5g-quantised", "Sleep5h" = "PSQI_5h-quantised","Sleep5i" = "PSQI_5i-quantised",
               "Sleep5j" = "PSQI_5j2-quantised", "Sleep6" = "PSQI_7-quantised","Sleep7" = "PSQI_8-quantised", "Sleep8" = "PSQI_9-quantised",
               "Sleep9" = "PSQI_6-quantised")

write_csv(PSQI,"~/Desktop/data_exp_16095_IT/Scored File IT//PSQIa_SHAPED_IT.csv")


# ripassare a mano Q2 E e salvarla come Sleep2