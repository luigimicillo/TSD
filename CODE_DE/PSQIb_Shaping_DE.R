# PSQI WEEK SHAPING FOR DE

# useful packages

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# import

library(readr)
S1_PSQI_week <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15575_DE/S1_PSQI-week.csv")
View(S1_PSQI_week)

# Shaping it
PSQI_W <- select(S1_PSQI_week,"Local Date", `Participant Private ID`,
                 `Question Key`, Response) %>%
  filter(grepl('PS',x=`Question Key`))

# Fixing the date and changing with the day name 

PSQI_W$`Local Date` <- substr(PSQI_W$`Local Date`, start = 0, stop = 10)
PSQI_W$"Local Date" <- weekdays(as.Date(PSQI_W$`Local Date`, tryFormats = c("%d/%m/%Y")))
PSQI_W <- rename(PSQI_W, "PSQI_W_DAY" = "Local Date")

# pivot

PSQI_W <- pivot_wider(PSQI_W, names_from = "Question Key", values_from = "Response")


# PSQI 1 IN MEDIA A CHE ORA SEI ANDATO A LETTO

PSQI_W$PSQI_W1 <- paste(PSQI_W$`PSQI_W_1-hour`, PSQI_W$`PSQI_W_1-minute`, sep = ":")
PSQI_W <- select(PSQI_W, -"PSQI_W_1-hour", -"PSQI_W_1-minute")

# PSQI 3 IN MEDIA A CHE ORA TI SEI SVEGLIATO

PSQI_W$PSQI_W3 <- paste(PSQI_W$`PSQI_W_3-hour`, PSQI_W$`PSQI_W_3-minute`, sep = ":")
PSQI_W <- select(PSQI_W, -"PSQI_W_3-hour", -"PSQI_W_3-minute")

# PSQI 4 in media quante ore  hai domrito
PSQI_W$PSQI_W4 <- paste(PSQI_W$`PSQI_W_4-hour`, PSQI_W$`PSQI_W_4-minute`, sep = ".")
PSQI_W <- select(PSQI_W, -"PSQI_W_4-hour", -"PSQI_W_4-minute")



# Renaming the variables in order to make them function in the script for the scoring

PSQI_W <- rename(PSQI_W, "Sleep1" = "PSQI_W1", "Sleep2" = "PSQI_W_2-minute", "Sleep3" = "PSQI_W3", "Sleep4" = "PSQI_W4", "Sleep5a" = "PSQI_W_5a-quantised",
                 "Sleep5b" = "PSQI_W_5b-quantised", "Sleep5c" = "PSQI_W_5c-quantised", "Sleep5d" = "PSQI_W_5d-quantised", "Sleep5e" = "PSQI_W_5e-quantised",
                 "Sleep5f" = "PSQI_W_5f-quantised", "Sleep5g" = "PSQI_W_5g-quantised", "Sleep5h" = "PSQI_W_5h-quantised","Sleep5i" = "PSQI_W_5i-quantised",
                 "Sleep5j" = "PSI_W_5j2-quantised", "Sleep6" = "PSQI_W_7-quantised","Sleep7" = "PSQI_W_8-quantised", "Sleep8" = "PSQI_W_9-quantised",
                 "Sleep9" = "PSQI_W_6-quantised")

# save the csv

write_csv(PSQI_W, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/DE//PSQIb_SHAPING_DE.csv")
