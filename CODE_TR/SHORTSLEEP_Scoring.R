# Useful Packages

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# import the different datasets

library(readr)
S1_ShortSleep_r1 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r1.csv")
View(S1_ShortSleep_r1)

library(readr)
S1_ShortSleep_r2 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r2.csv")
View(S1_ShortSleep_r2)

library(readr)
S1_ShortSleep_r3 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r3.csv")
View(S1_ShortSleep_r3)


# merging the datasets into one 

SHORTSLEEP_MERGED <- rbind(S1_ShortSleep_r1, S1_ShortSleep_r2, S1_ShortSleep_r3)


# recoding the Time point adding a new variable

SHORTSLEEP_MERGED <- mutate(SHORTSLEEP_MERGED, Time_point = recode(SHORTSLEEP_MERGED$`Tree Node Key`, "questionnaire-1r6m" = 1, "questionnaire-tti8" = 2, "questionnaire-86gt" = 3))


# Selecting the relevant variables

SHORTSLEEP_MERGED <- select(SHORTSLEEP_MERGED, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response",  "Time_point" ) %>%
  filter(grepl('SSQ',x=`Question Key`))

# Changing the UTC with the day name

SHORTSLEEP_MERGED$`Local Date` <- substr(SHORTSLEEP_MERGED$`Local Date`, start = 0, stop = 10)
SHORTSLEEP_MERGED$`Local Date` <- weekdays(as.Date(SHORTSLEEP_MERGED$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP_MERGED <- rename(SHORTSLEEP_MERGED, "SHORTSLEEP_Days" = "Local Date")

# Pivoting in order to have one line per participant

SHORTSLEEP_MERGED <- pivot_wider(SHORTSLEEP_MERGED, names_from = "Question Key", values_from = "Response")


# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP_MERGED$SSQ1 <- paste(SHORTSLEEP_MERGED$`SSQ_1-hour`, SHORTSLEEP_MERGED$`SSQ_1-minute`, sep=":")
SHORTSLEEP_MERGED <- select(SHORTSLEEP_MERGED, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP_MERGED$SSQ2 <- paste(SHORTSLEEP_MERGED$`SSQ_2-hour`, SHORTSLEEP_MERGED$`SSQ_2-minute`, sep=":")
SHORTSLEEP_MERGED <- select(SHORTSLEEP_MERGED, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP_MERGED$SSQ3 <- paste(SHORTSLEEP_MERGED$`SSQ_3-hour`, SHORTSLEEP_MERGED$`SSQ_3-minute`, sep=":")
SHORTSLEEP_MERGED <- select(SHORTSLEEP_MERGED, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP_MERGED$SSQ4 <- paste(SHORTSLEEP_MERGED$`SSQ_4-hour`, SHORTSLEEP_MERGED$`SSQ_4-minute`, sep=":")
SHORTSLEEP_MERGED <- select(SHORTSLEEP_MERGED, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order
colnames(SHORTSLEEP_MERGED)
SHORTSLEEP_MERGED <- SHORTSLEEP_MERGED[, c(1,2,3,4,9,10,11,12,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP_MERGED,"~/Desktop/data_exp_16095_IT/Scored File IT//SHORTSLEEPMERGED_SHAPED_IT.csv")
