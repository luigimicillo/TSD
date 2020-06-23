# USEFUL PACKAGES

# SHORTSLEEP ONE BY ONE

# SHORT SLEEP ROUND 1

library(readr)
S1_ShortSleep_r1 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r1.csv")

# Selecting the relevant variables

SHORTSLEEP <- select(S1_ShortSleep_r1, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP$`Local Date` <- substr(SHORTSLEEP$`Local Date`, start = 0, stop = 10)
SHORTSLEEP$`Local Date` <- weekdays(as.Date(SHORTSLEEP$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP <- rename(SHORTSLEEP, "SHORTSLEEP_Day_r1" = "Local Date")

SHORTSLEEP <- pivot_wider(SHORTSLEEP, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP$SSQ1r1 <- paste(SHORTSLEEP$`SSQ_1-hour`, SHORTSLEEP$`SSQ_1-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP$SSQ2r1 <- paste(SHORTSLEEP$`SSQ_2-hour`, SHORTSLEEP$`SSQ_2-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP$SSQ3r1 <- paste(SHORTSLEEP$`SSQ_3-hour`, SHORTSLEEP$`SSQ_3-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP$SSQ4r1 <- paste(SHORTSLEEP$`SSQ_4-hour`, SHORTSLEEP$`SSQ_4-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP <- rename(SHORTSLEEP,  "SSQ_5r1" = "SSQ_5", "SSQ_6r1" = "SSQ_6", "SSQ_7r1" = "SSQ_7", "SSQ_8r1" = "SSQ_8")
colnames(SHORTSLEEP)
SHORTSLEEP <- SHORTSLEEP[, c(1,2,3,8,9,10,11,4,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP,"~/Desktop/data_exp_16095_IT/Scored File IT//SHORTSLEEPr1_IT.csv")


# SHORTSLEEP ROUND 2

library(readr)
S1_ShortSleep_r2 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r2.csv")

# Selecting the relevant variables

SHORTSLEEP <- select(S1_ShortSleep_r2, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP$`Local Date` <- substr(SHORTSLEEP$`Local Date`, start = 0, stop = 10)
SHORTSLEEP$`Local Date` <- weekdays(as.Date(SHORTSLEEP$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP <- rename(SHORTSLEEP, "SHORTSLEEP_Day_r2" = "Local Date")

SHORTSLEEP <- pivot_wider(SHORTSLEEP, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP$SSQ1r2 <- paste(SHORTSLEEP$`SSQ_1-hour`, SHORTSLEEP$`SSQ_1-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP$SSQ2r2 <- paste(SHORTSLEEP$`SSQ_2-hour`, SHORTSLEEP$`SSQ_2-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP$SSQ3r2 <- paste(SHORTSLEEP$`SSQ_3-hour`, SHORTSLEEP$`SSQ_3-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP$SSQ4r2 <- paste(SHORTSLEEP$`SSQ_4-hour`, SHORTSLEEP$`SSQ_4-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP <- rename(SHORTSLEEP,  "SSQ_5r2" = "SSQ_5", "SSQ_6r2" = "SSQ_6", "SSQ_7r2" = "SSQ_7", "SSQ_8r2" = "SSQ_8")
colnames(SHORTSLEEP)
SHORTSLEEP <- SHORTSLEEP[, c(1,2,3,8,9,10,11,4,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP,"~/Desktop/data_exp_16095_IT/Scored File IT//SHORTSLEEPr2_IT.csv")

# ROUND 3 

library(readr)
S1_ShortSleep_r3 <- read_csv("Desktop/data_exp_16095_IT/S1_ShortSleep_r3.csv")

# Selecting the relevant variables

SHORTSLEEP <- select(S1_ShortSleep_r3, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP$`Local Date` <- substr(SHORTSLEEP$`Local Date`, start = 0, stop = 10)
SHORTSLEEP$`Local Date` <- weekdays(as.Date(SHORTSLEEP$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP <- rename(SHORTSLEEP, "SHORTSLEEP_Day_r3" = "Local Date")

SHORTSLEEP <- pivot_wider(SHORTSLEEP, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP$SSQ1r3 <- paste(SHORTSLEEP$`SSQ_1-hour`, SHORTSLEEP$`SSQ_1-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP$SSQ2r3 <- paste(SHORTSLEEP$`SSQ_2-hour`, SHORTSLEEP$`SSQ_2-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP$SSQ3r3 <- paste(SHORTSLEEP$`SSQ_3-hour`, SHORTSLEEP$`SSQ_3-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP$SSQ4r3 <- paste(SHORTSLEEP$`SSQ_4-hour`, SHORTSLEEP$`SSQ_4-minute`, sep=":")
SHORTSLEEP <- select(SHORTSLEEP, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP <- rename(SHORTSLEEP,  "SSQ_5r3" = "SSQ_5", "SSQ_6r3" = "SSQ_6", "SSQ_7r3" = "SSQ_7", "SSQ_8r3" = "SSQ_8")
colnames(SHORTSLEEP)
SHORTSLEEP <- SHORTSLEEP[, c(1,2,3,8,9,10,11,4,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP,"~/Desktop/data_exp_16095_IT/Scored File IT//SHORTSLEEPr3_IT.csv")

