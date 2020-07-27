# Organization and Preparation of the Italian Dataset:

# useful packages:

library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# Let's start from the Demographics, import the file 

S1_Demographics <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_Demographics.csv")

# Selecting the variables of interest: 

Demographics <- select(S1_Demographics, "Local Date", "Participant Private ID", "Question Key", "Response")

# Since there is no a "pattern" into the variables name i remove manually the "Begin Questionnaire" and "End Questionnaire" rows

Demographics$`Question Key` <-   recode(Demographics$`Question Key`, "BEGIN QUESTIONNAIRE" = "R", "END QUESTIONNAIRE" = "R")
Demographics <- filter(Demographics, Demographics$`Question Key` != "R")

# Let's save the date into the the "Local Date" column:

Demographics$`Local Date` <- substr(Demographics$`Local Date`, start = 0, stop = 10)
Demographics <- rename(Demographics, "DEMOG_Day" = "Local Date")

# we pivot the dataframe in order to have one line per participant:

Demographics <- pivot_wider(Demographics, names_from =`Question Key`,values_from = "Response")

# # i remove all the label variable keeping in mind that:

# SEX -> 1 = Male 2= Female ; Handedness ->  1 = Righthanded, 2 = Lefthanded; 
# Family, Friends and Colleagues -> 1= Mai , 2= Mensilmente, 3=  Settimanalmente, 4=gironalemnte, 5= molte volte al giorno;
# drug -> 1 = no, 2 = yes; Covidsymptoms -> 1 = yes, 2 = no, Covid -> 1 = I think so, 2 = , 3 = I have been tested, 4 = None of the previous ones
#  Occupation -> 1 = student, 2 = worker, 3= non-worker (disoccupato) ; Homework -> 1 = yes, 2 = no

Demographics <- select(Demographics, -"sex", -"handedness", -"family", -"friends", -"colleagues", -"drug", -"covidsymptoms", -"covid", -"Occupation", - "Homework")

# for what concerns Excitant quantised i recoded the variable in order to have 2 for yes and 1 for no since yes is signed with a missing value adn i removed the labelled one

Demographics$`excitant-quantised` <- replace_na(Demographics$`excitant-quantised`, 2)
Demographics <- select(Demographics, -"excitant")

# saving the CSV - remember to specify the nation in the file name

write_csv(Demographics,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_Demographics_IT.csv")

#####################################################################################################################################################
#####################################################################################################################################################

# Import the PSQI (month) 
S1_PSQI <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_PSQI.csv")

# Selecting the variables of interest and shaping it

PSQI <- select(S1_PSQI, "Participant Private ID",
               `Question Key`, Response) %>%
  filter(grepl('PSQI',x=`Question Key`))

# pivoting

PSQI <- pivot_wider(PSQI, names_from = "Question Key", values_from = "Response")

# deleting useless columns (Those of the roomate and the text ones)

colnames(PSQI) # remember to select the specific columns for each dataframe

PSQI <- PSQI[, c(1,2,3,4,5,6,7,8,9,11,14,15,18,20,21,23,25,27,32,31,34,36,38,40)]

# save this dataset into a .csv file

write_csv(PSQI,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_PSQIa_IT.csv")

# merge the PSQI and the Demographics into a new dataser called "df1"

df1 <- full_join(Demographics, PSQI, by = "Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# Import the muMCTQ

S1_MCQT <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_MCQT.csv")


# Selecting the variables of interest

muMCTQ<- select(S1_MCQT, "Participant Private ID", "Question Key", "Response") %>%
  filter(grepl('response',x=`Question Key`))

# pivot

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

# Save the Dataset

write_csv(muMCTQ,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_muMCTQ_IT.csv")

# adding also this dataset

df2 <- full_join(df1, muMCTQ, by = "Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# importing the rMEQ

S1_rMEQ <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_rMEQ.csv")

# selecting the variables of interest and recoding the values since we have not a quantised variable 

rMEQ <- select(S1_rMEQ, "Participant Private ID", "Question Key", ) %>%
  filter(grepl('response',x=`Question Key`)) %>%
  mutate(rMEQ_Quantised = recode(rMEQ$`Question Key`, "response-2-1" = 5, "response-2-2" = 4, "response-2-3" = 3, "response-2-4" = 2, "response-2-5" = 1,
                                 "response-3-1" = 1, "response-3-2" = 2, "response-3-3" = 3, "response-3-4" = 4,
                                 "response-4-1" = 5, "response-4-2" = 4, "response-4-3" = 3, "response-4-4" = 2, "response-4-5" = 1,
                                 "response-5-1" = 5, "response-5-2" = 4, "response-5-3" = 3, "response-5-4" = 2, "response-5-5" = 1,
                                 "response-6-1" = 6, "response-6-2" = 4, "response-6-3" = 2, "response-6-4" = 0,))

# Renaming the responses in Q2, Q3, Q4, Q5, Q6 according to gorilla 

rMEQ <- mutate(rMEQ, `Question Key` = str_replace(`Question Key`,"response-([2-6]-[1-6])",'Q\\1')) 
rMEQ$`Question Key` <- substr(rMEQ$`Question Key`, start = 0, stop = 2)

# pivoting the dataset

rMEQ <- pivot_wider(rMEQ, names_from =`Question Key`,values_from = rMEQ_Quantised)

# Scoring of the variable 

rMEQ <- mutate(rMEQ, rMEQ_score = Q2+Q3+Q4+Q5+Q6) %>% 
  select(-starts_with('Q'))

# Adding a label to the score

rMEQ$rMEQ_Labelscore <- cut(rMEQ$rMEQ_score,c(0, 11, 19, 25), right = FALSE, labels = c("Evening-Type", "Intermediate-type", "Morning-type"))

# save the rMEQ into a .csv file 

write_csv(rMEQ,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_rMEQ_IT.csv")

# adding the dataframe to the previus ones

df3 <- full_join(df2, rMEQ, by ="Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# importing the ZITP

S1_ZITP <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_ZITP.csv")

# Shaping the dataset, selecting the useful variables, rename the question keys and pivoting the dataset
Zitp <- select(S1_ZITP,`Participant Private ID`,
               `Question Key`, Response) %>%
  filter(grepl('-quantised',x=`Question Key`)) %>%
  mutate(`Question Key` = str_replace(`Question Key`,"q([0-9]+)-quantised",'Q\\1'),
         Response = as.numeric(Response)) %>% 
  mutate( `Question Key` = str_replace(`Question Key`,"q_01-quantised",'Q01')) %>%
  pivot_wider(names_from = `Question Key`,values_from = Response) %>%
  
  # scoring of the questionnaires, it should be runned together with the previous part
  
  mutate(PastNegative= (Q04+Q05+Q16+Q22+Q27+Q33+Q34+Q36+Q50+Q54)/10) %>%
  mutate(PresentHedonistic= (Q01+Q08+Q12+Q17+Q19+Q23+Q26+Q28+Q31+Q32+Q42+Q44+Q46+Q48+Q55)/15) %>%
  mutate(Future = (Q06+(6-Q09)+Q10+Q13+Q18+Q21+(6-Q24)+Q30+Q40+Q43+Q45+Q51+Q56)/13)%>%
  mutate(Past_Positive = (Q02+Q07+Q11+Q15+Q20+(6-Q25)+Q29+(6-Q41))/9)%>%
  mutate(Present_Fatalistic = (Q03+Q14+Q35+Q37+Q38+Q39+Q47+Q52+Q53)/9) %>%
  select(-starts_with('Q'))

# Saveng the ZITP into a .csv file

write_csv(Zitp,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_ZITP_IT.csv")

# I merge together the two datasets and rename it df1

df4 <- full_join(df3, Zitp, by = "Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# importing the BFI

S1_BFI <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_BFI.csv")

# Selecting the variables of interest

BFI <- select(S1_BFI, `Participant Private ID`,
              `Question Key`, Response) %>%
  filter(grepl('BFI',x=`Question Key`))

# pivot 

BFI <- pivot_wider(BFI, names_from = "Question Key", values_from = Response)

# keeping the quantised variables

colnames(BFI)

BFI <- BFI[,c(1,3,5,7,9,11,13,15,17,19,21)]

# saving the BFI into a .csv file 

write_csv(BFI,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_BFI_IT.csv")

# adding the BFI 

df5 <- full_join(df4, BFI, by = "Participant Private ID")


#####################################################################################################################################################
#####################################################################################################################################################

# importing the HADS round 1

S1_HADS_r1 <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_HADS_r1.csv")

# Selecting the variables of interest
HADSr1 <- select(S1_HADS_r1, `Participant Private ID`,
                 `Question Key`, Response) %>%
  filter(grepl('HADS',x=`Question Key`))

# extracting the scores of the variable since we do not have a "quantised one"

HADSr1$`Question Key` <- substr(HADSr1$`Question Key`, start = 0, stop = 9)
HADSr1$`Response` <- substr(HADSr1$Response, start = 0, stop = 1)
HADSr1$T1 <- c("t1")
HADSr1$`Question Key` <- paste(HADSr1$`Question Key`, HADSr1$T1, sep = "-")
HADSr1 <- select(HADSr1, -"T1")

# Pivot in order to have one row per participant 

HADSr1 <- pivot_wider(HADSr1, names_from = "Question Key", values_from = "Response")

# Saving also the HADS r1 into a .csv file 

write_csv(HADSr1,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_HADSr1_IT.csv")

# adding the HADS to the dataframes

df6 <- full_join(df5, BFI, by ="Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# import the second round of HADS (the code is similar to the one of the first round)

S1_HADS_r2 <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_HADS_r2.csv")

HADSr2 <- select(S1_HADS_r2, `Participant Private ID`,
                 `Question Key`, Response) %>%
  filter(grepl('HADS',x=`Question Key`))

HADSr2$`Question Key` <- substr(HADSr2$`Question Key`, start = 0, stop = 9)
HADSr2$`Response` <- substr(HADSr2$Response, start = 0, stop = 1)
HADSr2$T2 <- c("t2")
HADSr2$`Question Key` <- paste(HADSr2$`Question Key`, HADSr2$T2, sep = "-")
HADSr2 <- select(HADSr2, -"T2")

HADSr2 <- pivot_wider(HADSr2, names_from = "Question Key", values_from = "Response")

# saving this dataset into a .csv file 

write_csv(HADSr2,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_HADSr2_IT.csv")

# adding the dataset to the previous ones 

df7 <- full_join(df6, HADSr2, by = "Participant Private ID")

#####################################################################################################################################################
#####################################################################################################################################################

# import the PSQI week 

S1_PSQI_week <- read_csv("Desktop/TIME SOCIAL DISTANCING DATA/RAW DATASETS/ITALY/S1_PSQI-week.csv")

# Shaping the Dataset at the same way of the previous PSQI

PSQI_W <- select(S1_PSQI_week,`Participant Private ID`,
                 `Question Key`, Response) %>%
  filter(grepl('PS',x=`Question Key`))

# pivoting

PSQI_W <- pivot_wider(PSQI_W, names_from = "Question Key", values_from = "Response")

colnames(PSQI_W)

PSQI_W <- PSQI_W[,c(1,2,4,3,5,6,7,8,9,11,13,14,17,19,21,23,25,27,29, 32,35,36,38,40)]

# saving the datset in a .csv file 

write_csv(PSQI_W,"~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/SHAPED\ DATASETS/ITALY//S1_PSQI_W_IT.csv")


# adding also the PSQI week 

df8 <- full_join(df7, PSQI_W, by = "Participant Private ID")


# SAVE THE CSV FOR THE WHOLE DATASET (df8)

write_csv(df8, "~/Desktop/TIME\ SOCIAL\ DISTANCING\ DATA/MERGED\ FOR\ NATIONS//MERGED_IT.csv")
