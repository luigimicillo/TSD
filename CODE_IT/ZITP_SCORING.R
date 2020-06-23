# SCORING OF THE ZITP

# USEFUL PACKAGES

library(dplyr)
library(tidyr)
library(stringr)
library(na.tools)
library(tibble)

# Import the dataset

library(readr)
S1_ZITP <- read_csv("~/Desktop/data_exp_16095_IT/S1_ZITP.csv")
View(S1_ZITP)

# Shaping the dataset
Zitp_shaped <- select(S1_ZITP,`Participant Private ID`,`Schedule ID`,
                      `Question Key`, Response) %>%
  filter(grepl('-quantised',x=`Question Key`)) %>%
  mutate(`Question Key` = str_replace(`Question Key`,"q([0-9]+)-quantised",'Q\\1'),
         Response = as.numeric(Response)) %>% 
  mutate( `Question Key` = str_replace(`Question Key`,"q_01-quantised",'Q01')) %>%
  pivot_wider(names_from = `Question Key`,values_from = Response) %>% 
  
  # scoring of the questionnaires 
  
  mutate(PastNegative= (Q04+Q05+Q16+Q22+Q27+Q33+Q34+Q36+Q50+Q54)/10) %>%
  mutate(PresentHedonistic= (Q01+Q08+Q12+Q17+Q19+Q23+Q26+Q28+Q31+Q32+Q42+Q44+Q46+Q48+Q55)/15) %>%
  mutate(Future = (Q06+(6-Q09)+Q10+Q13+Q18+Q21+(6-Q24)+Q30+Q40+Q43+Q45+Q51+Q56)/13)%>%
  mutate(Past_Positive = (Q02+Q07+Q11+Q15+Q20+(6-Q25)+Q29+(6-Q41))/9)%>%
  mutate(Present_Fatalistic = (Q03+Q14+Q35+Q37+Q38+Q39+Q47+Q52+Q53)/9) %>%
  select(-starts_with('Q'))
         
# saving the csv of the scored file 

write.csv(Zitp_shaped, "~/Desktop/data_exp_16095_IT/Scored File IT//ZITP_SCORED_IT.csv") 
 
  
