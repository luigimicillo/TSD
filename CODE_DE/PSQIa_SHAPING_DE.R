# SCORING THE PSQI FOR DE

# Useful packages

# Import

library(readr)
S1_PSQI <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15575_DE/S1_PSQI.csv")
View(S1_PSQI)

# Shape

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


# Renaming the variables in order to make them function in the script for the scoring

PSQI <- rename(PSQI, "Sleep1" = "PSQI_1", "Sleep2" = "PSQI_2-minute", "Sleep3" = "PSQI_3", "Sleep4" = "PSQI_4", "Sleep5a" = "PSQI_5a-quantised",
               "Sleep5b" = "PSQI_5b-quantised", "Sleep5c" = "PSQI_5c-quantised", "Sleep5d" = "PSQI_5d-quantised", "Sleep5e" = "PSQI_5e-quantised",
               "Sleep5f" = "PSQI_5f-quantised", "Sleep5g" = "PSQI_5g-quantised", "Sleep5h" = "PSQI_5h-quantised","Sleep5i" = "PSQI_5i-quantised",
               "Sleep5j" = "PSQI_5j2-quantised", "Sleep6" = "PSQI_7-quantised","Sleep7" = "PSQI_8-quantised", "Sleep8" = "PSQI_9-quantised",
               "Sleep9" = "PSQI_6-quantised")

# save the csv

write_csv(PSQI, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/DE//PSQIa_SHAPED_DE.csv")
