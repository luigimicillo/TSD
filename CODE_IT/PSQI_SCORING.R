
## PSQI SCORING: adapted from https://rdrr.io/github/wzhou7/Fruved/src/R/PSQI.R

# import
library(readr)
PSQIa_SHAPED <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/PSQIa_SHAPED.csv")
# or
PSQIb_SHAPED_IT <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/PSQIb_SHAPED_IT.csv")

# Rename the dataset in order to not change everything in the coding script, REMEMBER TO SAVE WITH THE COUNTRY AND THE TYPE OF PSQI

PSQISHAPED <- PSQIb_SHAPED_IT


# create the variables 
PSQISHAPED$Comp1 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp2 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp3 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp4 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp5 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp6 <- rep(NA,nrow(PSQISHAPED))
PSQISHAPED$Comp7 <- rep(NA,nrow(PSQISHAPED))


# COMPONENT 1 

PSQISHAPED$Comp1 <- PSQISHAPED$Sleep9 - 1


# COMPONENT 2

Score2 <- rep(NA,nrow(PSQISHAPED))
Score2[PSQISHAPED$Sleep2<=15] <- 0
Score2[PSQISHAPED$Sleep2>15 & PSQISHAPED$Sleep2<=30] <- 1
Score2[PSQISHAPED$Sleep2>30 & PSQISHAPED$Sleep2<=60] <- 2
Score2[PSQISHAPED$Sleep2>60] <- 3

Score_Comp2 <- Score2 + PSQISHAPED$Sleep5a - 1

PSQISHAPED$Comp2[Score_Comp2==0] <- 0
PSQISHAPED$Comp2[Score_Comp2==1 | Score_Comp2==2] <- 1
PSQISHAPED$Comp2[Score_Comp2==3 | Score_Comp2==4] <- 2
PSQISHAPED$Comp2[Score_Comp2==5 | Score_Comp2==6] <- 3

# COMPONENT 3
PSQISHAPED$Sleep4 <- as.numeric(PSQISHAPED$Sleep4)
PSQISHAPED$Comp3[PSQISHAPED$Sleep4>=07] <- 0
PSQISHAPED$Comp3[PSQISHAPED$Sleep4>=06 & PSQISHAPED$Sleep4<07] <- 1
PSQISHAPED$Comp3[PSQISHAPED$Sleep4>=05 & PSQISHAPED$Sleep4<06] <- 2
PSQISHAPED$Comp3[PSQISHAPED$Sleep4<05] <- 3

# COMPONENT 4
Hours_in_Bed<- as.numeric(difftime(strptime(PSQISHAPED$Sleep3, "%H:%M" ),strptime(PSQISHAPED$Sleep1, "%H:%M" ),units='hours'))
Hours_in_Bed[!is.na(Hours_in_Bed) & Hours_in_Bed<0] <- 24 + Hours_in_Bed[!is.na(Hours_in_Bed) & Hours_in_Bed<0] 

Score_Comp4 <- rep(NA,nrow(PSQISHAPED))
Score_Comp4 <- PSQISHAPED$Sleep4/Hours_in_Bed*100
PSQISHAPED$Comp4[Score_Comp4 >= 85] <- 0
PSQISHAPED$Comp4[Score_Comp4 >= 75 & Score_Comp4 < 85] <- 1
PSQISHAPED$Comp4[Score_Comp4 >= 65 & Score_Comp4 < 75] <- 2
PSQISHAPED$Comp4[Score_Comp4 < 65] <- 3

# COMPONENT 5 

PSQISHAPED$Sleep5j[is.na(PSQISHAPED$Sleep5j) | PSQISHAPED$Sleep5j==""] <- 1
Score_Comp5 <- PSQISHAPED$Sleep5b + PSQISHAPED$Sleep5c + PSQISHAPED$Sleep5d + PSQISHAPED$Sleep5e + PSQISHAPED$Sleep5f + PSQISHAPED$Sleep5g + PSQISHAPED$Sleep5h + PSQISHAPED$Sleep5i + PSQISHAPED$Sleep5j- 9
PSQISHAPED$Comp5[Score_Comp5 == 0] <- 0
PSQISHAPED$Comp5[Score_Comp5 >= 1 & Score_Comp5 <= 9] <- 1
PSQISHAPED$Comp5[Score_Comp5 >= 10 & Score_Comp5 <= 18] <- 2
PSQISHAPED$Comp5[Score_Comp5 >= 19 & Score_Comp5 <= 27] <- 3

# COMPONENT 6

PSQISHAPED$Comp6 <- PSQISHAPED$Sleep6 - 1

# COMPONENT 7
Score_Comp7 <- PSQISHAPED$Sleep7 - 1 + PSQISHAPED$Sleep8 - 1
PSQISHAPED$Comp7[Score_Comp7==0] <- 0
PSQISHAPED$Comp7[Score_Comp7==1 | Score_Comp7==2] <- 1
PSQISHAPED$Comp7[Score_Comp7==3 | Score_Comp7==4] <- 2
PSQISHAPED$Comp7[Score_Comp7==5 | Score_Comp7==6] <- 3

# TOTAL

PSQISHAPED$PSQI_TOT = PSQISHAPED$Comp1 + PSQISHAPED$Comp2 + PSQISHAPED$Comp3 + PSQISHAPED$Comp4 + PSQISHAPED$Comp5 + PSQISHAPED$Comp6 + PSQISHAPED$Comp7


# inserire select e togliere le inutili (il giorno va rinominato sempre)

PSQISHAPED <- select(PSQISHAPED, "PSQI_W_DAY", "Participant Private ID", "Comp1", "Comp2", "Comp3", "Comp4", "Comp5", "Comp6", "Comp7", "PSQI_TOT")

# salvare il csv RICORDATI DI INSERIRE IL NOME DELLA NAZIONE E IL TIPO DI PSQI
