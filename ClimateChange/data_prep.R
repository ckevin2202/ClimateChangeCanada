# remove all variables from the workspace
rm(list = ls(all = TRUE))

# close all previous plots
while (!is.null(dev.list())) dev.off()

# import library
library(tidyverse)
library(lubridate)

# set working directory
getwd()
setwd("~/sfuvault/SFU/Term 14-Spring 2019/STAT 240/Assignments/Assignment 9/Datasets")

# Load CO2 and Weather Datasets
# CO2
load(file = "C02Worldwide.Rdata")
load(file = "C02NorthernHemisphere.Rdata")

# Weather
load(file = "CanadianMinTemp.Rdata")
load(file = "CanadianMeanTemp.Rdata")
load(file = "CanadianMaxTemp.Rdata")
load(file = "CanadianAvgSnow.Rdata")
load(file = "CanadianPrecip.Rdata")

# Data Manipulation
# CO2
# get the year for Co2North
Co2North <- Co2North %>% 
  mutate(Year = as.integer(substring(YearDecimal,1,4)))
# Weather
# replace missing values -9999.9 with NA
MeanTemp[!is.na(MeanTemp)&(MeanTemp==-9999.9)] <- NA
MinTemp[!is.na(MinTemp)&(MinTemp==-9999.9)] <- NA
MaxTemp[!is.na(MaxTemp)&(MaxTemp==-9999.9)] <- NA
AllSnow[!is.na(AllSnow)&(AllSnow==-9999.9)] <- NA
AllPrecip[!is.na(AllPrecip)&(AllPrecip==-9999.9)] <- NA

# Save the data output
save(Co2World,file="C02Worldwide_v2.Rdata")
save(Co2North,file="C02NorthernHemisphere_v2.Rdata")
save(MinTemp,file="CanadianMinTemp_v2.Rdata")
save(MeanTemp,file="CanadianMeanTemp_v2.Rdata")
save(MaxTemp,file="CanadianMaxTemp_v2.Rdata")
save(AllSnow,file="CanadianAvgSnow_v2.Rdata")
save(AllPrecip,file="CanadianPrecip_v2.Rdata")

# Consolidate the data
MinTemp_Summary <- MinTemp %>% 
  rename(Annual_MinTemp = Annual,
         Winter_MinTemp = Winter,
         Spring_MinTemp = Spring,
         Summer_MinTemp = Summer, 
         Autumn_MinTemp = Autumn,
         Province = "InfoTemp[3]") %>% 
  select(Year,Province, Annual_MinTemp, Winter_MinTemp, Spring_MinTemp, Summer_MinTemp, Autumn_MinTemp) %>% 
  arrange(Year)
MaxTemp_Summary <- MaxTemp %>% 
  rename(Year1 = Year,
         Annual_MaxTemp = Annual,
         Winter_MaxTemp = Winter,
         Spring_MaxTemp = Spring,
         Summer_MaxTemp = Summer, 
         Autumn_MaxTemp = Autumn) %>% 
  select(Year1, Annual_MaxTemp, Winter_MaxTemp, Spring_MaxTemp, Summer_MaxTemp, Autumn_MaxTemp) %>% 
  arrange(Year1)
MeanTemp_Summary <- MeanTemp %>% 
  rename(Year2 = Year,
         Annual_MeanTemp = Annual,
         Winter_MeanTemp = Winter,
         Spring_MeanTemp = Spring,
         Summer_MeanTemp = Summer, 
         Autumn_MeanTemp = Autumn) %>% 
  select(Year2,Annual_MeanTemp, Winter_MeanTemp, Spring_MeanTemp, Summer_MeanTemp, Autumn_MeanTemp) %>% 
  arrange(Year2)
AllSnow_Summary <- AllSnow %>% 
  rename(Annual_AllSnow = Annual,
         Winter_AllSnow = Winter,
         Spring_AllSnow = Spring,
         Summer_AllSnow = Summer, 
         Autumn_AllSnow = Autumn) %>% 
  select(Year,Annual_AllSnow, Winter_AllSnow, Spring_AllSnow, Summer_AllSnow, Autumn_AllSnow) %>% 
  arrange(Year)
AllPrecip_Summary <- AllPrecip %>% 
  rename(Annual_AllPrecip = Annual,
         Winter_AllPrecip = Winter,
         Spring_AllPrecip = Spring,
         Summer_AllPrecip = Summer, 
         Autumn_AllPrecip = Autumn) %>% 
  select(Year,Annual_AllPrecip, Winter_AllPrecip, Spring_AllPrecip, Summer_AllPrecip, Autumn_AllPrecip) %>% 
  arrange(Year)
Temperature_Summary <- cbind(MinTemp_Summary,MeanTemp_Summary,MaxTemp_Summary)

# Combine & Summarize Data
# Weather
Temperature_Summary <- Temperature_Summary %>% 
  select(-Year1, -Year2) %>% 
  group_by(Year) %>% 
  summarise(
    Annual_MinTemp = mean(Annual_MinTemp, na.rm = TRUE),
    Winter_MinTemp = mean(Winter_MinTemp, na.rm = TRUE),
    Spring_MinTemp = mean(Spring_MinTemp, na.rm = TRUE),
    Summer_MinTemp = mean(Summer_MinTemp, na.rm = TRUE),
    Autumn_MinTemp = mean(Autumn_MinTemp, na.rm = TRUE),
    Annual_MeanTemp = mean(Annual_MeanTemp, na.rm = TRUE),
    Winter_MaxTemp = mean(Winter_MaxTemp, na.rm = TRUE),
    Spring_MeanTemp = mean(Spring_MeanTemp, na.rm = TRUE),
    Summer_MeanTemp = mean(Summer_MeanTemp, na.rm = TRUE),
    Autumn_MeanTemp = mean(Autumn_MeanTemp, na.rm = TRUE),
    Annual_MaxTemp = mean(Annual_MaxTemp, na.rm = TRUE),
    Winter_MaxTemp = mean(Winter_MaxTemp, na.rm = TRUE),
    Spring_MaxTemp = mean(Spring_MaxTemp, na.rm = TRUE),
    Summer_MaxTemp = mean(Summer_MaxTemp, na.rm = TRUE),
    Autumn_MaxTemp = mean(Autumn_MaxTemp, na.rm = TRUE)
  )
Temperature_Summary

AllSnow_Summary <- AllSnow_Summary %>% 
  group_by(Year) %>% 
  summarise_all(mean, na.rm = TRUE)
AllSnow_Summary

AllPrecip_Summary <- AllPrecip_Summary %>% 
  group_by(Year) %>% 
  summarise_all(mean, na.rm = TRUE)
AllPrecip_Summary

Co2World_Summary <- Co2World %>% 
  group_by(Year) %>% 
  summarise(
    Value = mean(Value, na.rm = TRUE),
    Uncertainty = mean(Uncertainty, na.rm = T)
  )
Co2World_Summary

Co2North_Summary <- Co2North %>% 
  select(-YearDecimal) %>% 
  group_by(Year) %>% 
  summarise_all(mean, na.rm = TRUE)
Co2North_Summary

MeanTemp_Summary_prov_data <- MeanTemp %>% 
  rename(Year = Year,
         Annual_MeanTemp = Annual,
         Winter_MeanTemp = Winter,
         Spring_MeanTemp = Spring,
         Summer_MeanTemp = Summer, 
         Autumn_MeanTemp = Autumn,
         Province = "InfoTemp[3]") %>% 
  select(Year,Province,Annual_MeanTemp, Winter_MeanTemp, Spring_MeanTemp, Summer_MeanTemp, Autumn_MeanTemp) %>% 
  arrange(Year)
MeanTemp_Summary_prov_data

MeanTemp_Summary_prov_anomaly <- MeanTemp_Summary_prov_data %>% 
  filter((Year >= 1977) & (Year <= 2017)) %>% 
  group_by(Province) %>% 
  summarise(Annual_MeanTemp =  mean(Annual_MeanTemp, na.rm = TRUE)) %>% 
  mutate(anomaly = Annual_MeanTemp - mean(Annual_MeanTemp, na.rm = TRUE)) %>% 
  select(Province, anomaly)
MeanTemp_Summary_prov_anomaly

# Write CSV
write_csv(Temperature_Summary,'Temperature_Summary.csv')
write_csv(AllSnow_Summary,'AllSnow_Summary.csv')
write_csv(AllPrecip_Summary,'AllPrecip_Summary.csv')
write_csv(Co2World_Summary,'Co2World_Summary.csv')
write_csv(Co2North_Summary,'Co2North_Summary.csv')
write_csv(MeanTemp_Summary_prov_anomaly,'MeanTemp_Summary_prov_anomaly.csv')