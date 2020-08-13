#Analysis_1_Historical_Timeseries

### load packages
library(tidyverse)
library(tidyr)
library(lubridate)
library(data.table)
library(janitor)
library(readxl)
library(writexl)
library(xtable)
library(nlme)
library(scales)
library(zoo)
Sys.setenv(TZ='UTC')



# unweighted data from NEMSIGHT
#############################

prices <- fread("D:/Data/Nemsight/Monthly_Prices.csv") %>% clean_names() %>% 
  mutate(month = as.Date(month, format = "%d/%m/%Y")) %>% 
  pivot_longer(cols = -month, names_to = "region")

#graphs

#monthly
ggplot(prices, aes(x = month, y = value, colour = region))+
  geom_line()

#yearly
ggplot(prices %>% group_by(year = year(month), region) %>% summarise(value = mean(value)) %>% filter(year < 2020), 
       aes(x = year, y = value, colour = region))+
  geom_line(size = 1)

# Weighted graphs + data can be found on AER
# They also include Gas markets

# https://www.aer.gov.au/wholesale-markets/wholesale-statistics