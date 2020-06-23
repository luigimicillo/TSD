# useful packages

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# import the dataset

library(readr)
S1_rMEQ <- read_csv("~/Desktop/data_exp_16095_IT/S1_rMEQ.csv")
View(S1_rMEQ)

# Shaping the Questionnaire (since I need this dataset for both the projects i will take the UTC local date and transform it into days of the week)
# and I recode the values of the response variables
rMEQ <- select(S1_rMEQ, "Local Date", "Participant Private ID", "Question Key", ) %>%
  filter(grepl('response',x=`Question Key`)) %>%
  mutate(rMEQ_Quantised = recode(rMEQ$`Question Key`, "response-2-1" = 5, "response-2-2" = 4, "response-2-3" = 3, "response-2-4" = 2, "response-2-5" = 1,
                                 "response-3-1" = 1, "response-3-2" = 2, "response-3-3" = 3, "response-3-4" = 4,
                                 "response-4-1" = 5, "response-4-2" = 4, "response-4-3" = 3, "response-4-4" = 2, "response-4-5" = 1,
                                 "response-5-1" = 5, "response-5-2" = 4, "response-5-3" = 3, "response-5-4" = 2, "response-5-5" = 1,
                                 "response-6-1" = 6, "response-6-2" = 4, "response-6-3" = 2, "response-6-4" = 0,))

rMEQ$`Local Date` <- substr(rMEQ$`Local Date`, start=0, stop=10)
rMEQ$"Local Date" <- weekdays(as.Date(rMEQ$`Local Date`, tryFormats = c("%d/%m/%Y")))
rMEQ <- rename(rMEQ, "rMEQ_Day" = "Local Date")
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


# saving the CSV
write_csv(rMEQ,"~/Desktop/data_exp_16095_IT/Scored File IT//rMEQ_SCORED_IT.csv")
