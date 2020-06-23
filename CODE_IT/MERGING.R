# Useful Packages

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# IMPORTING THE DATASETS

library(readr)
DEMOG_SHAPED <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/DEMOG_SHAPED.csv")
muMCTQ_shaped <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/muMCTQ_shaped.csv")
rMEQ_SCORED <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/rMEQ_SCORED.csv")
SHORTSLEEPr1_IT <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/SHORTSLEEPr1_IT.csv")
SHORTSLEEPr2_IT <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/SHORTSLEEPr2_IT.csv")
SHORTSLEEPr3_IT <- read_csv("Desktop/data_exp_16095_IT/Scored File IT/SHORTSLEEPr3_IT.csv")


# MERGING THE DATAFRAMES 
df1 <- full_join(DEMOG_SHAPED, muMCTQ_shaped, by = "Participant Private ID")
df2 <- full_join(df1,rMEQ_SCORED, by = "Participant Private ID")
df3 <- full_join(df2, SHORTSLEEPr1_IT, by = "Participant Private ID")
df4 <- full_join(df3, SHORTSLEEPr2_IT, by = "Participant Private ID")
df5 <- full_join(df4, SHORTSLEEPr3_IT, by = "Participant Private ID")


# SAVING THE DATAFRAME (RENAME THE FILE WITH THE NAME OF THE COUNTRY)
write.csv(df5, file = "~/Desktop/data_exp_16095_IT/Scored File IT//Merged_IT.csv")
