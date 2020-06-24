# SHORTSLEEP FOR FR


# import datasets

S1_ShortSleep_r1 <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15096-16303_FR/S1_ShortSleep_r1.csv")
View(S1_ShortSleep_r1)

SHORTSLEEP1 <- select(S1_ShortSleep_r1, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP1$`Local Date` <- substr(SHORTSLEEP1$`Local Date`, start = 0, stop = 10)
SHORTSLEEP1$`Local Date` <- weekdays(as.Date(SHORTSLEEP1$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP1 <- rename(SHORTSLEEP1, "SHORTSLEEP_Day_r1" = "Local Date")

SHORTSLEEP1 <- pivot_wider(SHORTSLEEP1, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP1$SSQ1r1 <- paste(SHORTSLEEP1$`SSQ_1-hour`, SHORTSLEEP1$`SSQ_1-minute`, sep=":")
SHORTSLEEP1 <- select(SHORTSLEEP1, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP1$SSQ2r1 <- paste(SHORTSLEEP1$`SSQ_2-hour`, SHORTSLEEP1$`SSQ_2-minute`, sep=":")
SHORTSLEEP1 <- select(SHORTSLEEP1, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP1$SSQ3r1 <- paste(SHORTSLEEP1$`SSQ_3-hour`, SHORTSLEEP1$`SSQ_3-minute`, sep=":")
SHORTSLEEP1<- select(SHORTSLEEP1, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP1$SSQ4r1 <- paste(SHORTSLEEP1$`SSQ_4-hour`, SHORTSLEEP1$`SSQ_4-minute`, sep=":")
SHORTSLEEP1 <- select(SHORTSLEEP1, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP1 <- rename(SHORTSLEEP1,  "SSQ_5r1" = "SSQ_5", "SSQ_6r1" = "SSQ_6", "SSQ_7r1" = "SSQ_7", "SSQ_8r1" = "SSQ_8")
colnames(SHORTSLEEP1)
SHORTSLEEP1 <- SHORTSLEEP1[, c(1,2,3,8,9,10,11,4,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP1, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/FR//SHORTSLEEPr1FR.csv")



################### ROUND 2

#import 
S1_ShortSleep_r2 <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15096-16303_FR/S1_ShortSleep_r2.csv")

# Selecting the relevant variables

SHORTSLEEP2 <- select(S1_ShortSleep_r2, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP2$`Local Date` <- substr(SHORTSLEEP2$`Local Date`, start = 0, stop = 10)
SHORTSLEEP2$`Local Date` <- weekdays(as.Date(SHORTSLEEP2$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP2 <- rename(SHORTSLEEP2, "SHORTSLEEP_Day_r2" = "Local Date")

SHORTSLEEP2 <- pivot_wider(SHORTSLEEP2, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP2$SSQ1r2 <- paste(SHORTSLEEP2$`SSQ_1-hour`, SHORTSLEEP2$`SSQ_1-minute`, sep=":")
SHORTSLEEP2 <- select(SHORTSLEEP2, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP2$SSQ2r2 <- paste(SHORTSLEEP2$`SSQ_2-hour`, SHORTSLEEP2$`SSQ_2-minute`, sep=":")
SHORTSLEEP2 <- select(SHORTSLEEP2, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP2$SSQ3r2 <- paste(SHORTSLEEP2$`SSQ_3-hour`, SHORTSLEEP2$`SSQ_3-minute`, sep=":")
SHORTSLEEP2 <- select(SHORTSLEEP2, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP2$SSQ4r2 <- paste(SHORTSLEEP2$`SSQ_4-hour`, SHORTSLEEP2$`SSQ_4-minute`, sep=":")
SHORTSLEEP2 <- select(SHORTSLEEP2, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP2 <- rename(SHORTSLEEP2,  "SSQ_5r2" = "SSQ_5", "SSQ_6r2" = "SSQ_6", "SSQ_7r2" = "SSQ_7", "SSQ_8r2" = "SSQ_8")
colnames(SHORTSLEEP2)
SHORTSLEEP2 <- SHORTSLEEP2[, c(1,2,3,8,9,10,11,4,5,6,7)]

write_csv(SHORTSLEEP2, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/FR//SHORTSLEEPr2FR.csv")



############# ROUND THREE

#import

S1_ShortSleep_r3 <- read_csv("Desktop/data_exp_16095_IT/RAW OTHER/data_exp_15096-16303_FR/S1_ShortSleep_r3.csv")


# Selecting the relevant variables

SHORTSLEEP3 <- select(S1_ShortSleep_r3, "Local Date", "Schedule ID", "Participant Private ID", "Question Key", "Response" ) %>%
  filter(grepl('SSQ',x=`Question Key`))


SHORTSLEEP3$`Local Date` <- substr(SHORTSLEEP3$`Local Date`, start = 0, stop = 10)
SHORTSLEEP3$`Local Date` <- weekdays(as.Date(SHORTSLEEP3$`Local Date`, tryFormats = c("%d/%m/%Y")))
SHORTSLEEP3 <- rename(SHORTSLEEP3, "SHORTSLEEP_Day_r3" = "Local Date")

SHORTSLEEP3 <- pivot_wider(SHORTSLEEP3, names_from = "Question Key", values_from = "Response")

# SSQ1 A che ora sei andato a letto ieri?

SHORTSLEEP3$SSQ1r3 <- paste(SHORTSLEEP3$`SSQ_1-hour`, SHORTSLEEP3$`SSQ_1-minute`, sep=":")
SHORTSLEEP3 <- select(SHORTSLEEP3, -"SSQ_1-hour", -"SSQ_1-minute")

# SSQ2 a che ora ti sei alzato stamattina?

SHORTSLEEP3$SSQ2r3 <- paste(SHORTSLEEP3$`SSQ_2-hour`, SHORTSLEEP3$`SSQ_2-minute`, sep=":")
SHORTSLEEP3 <- select(SHORTSLEEP3, -"SSQ_2-hour", -"SSQ_2-minute")

# SSQ3 a che ora ti sei effettivamente addormentato?

SHORTSLEEP3$SSQ3r3 <- paste(SHORTSLEEP3$`SSQ_3-hour`, SHORTSLEEP3$`SSQ_3-minute`, sep=":")
SHORTSLEEP3 <- select(SHORTSLEEP3, -"SSQ_3-hour", -"SSQ_3-minute")

# SSQ 4 A che ora ti sei effettivamente svegliato

SHORTSLEEP3$SSQ4r3 <- paste(SHORTSLEEP3$`SSQ_4-hour`, SHORTSLEEP3$`SSQ_4-minute`, sep=":")
SHORTSLEEP3 <- select(SHORTSLEEP3, -"SSQ_4-hour", -"SSQ_4-minute")

# Put them in order and rename basing on the round
SHORTSLEEP3 <- rename(SHORTSLEEP3,  "SSQ_5r3" = "SSQ_5", "SSQ_6r3" = "SSQ_6", "SSQ_7r3" = "SSQ_7", "SSQ_8r3" = "SSQ_8")
colnames(SHORTSLEEP3)
SHORTSLEEP3 <- SHORTSLEEP3[, c(1,2,3,8,9,10,11,4,5,6,7)]

# Save the CSV (il resto lo passo a mano, diventa un problema per le altre lingue)

write_csv(SHORTSLEEP3, "/Users/luigimicillo/Desktop/data_exp_16095_IT/Scored\ Files\ Other/FR//SHORTSLEEPr3FR.csv")
