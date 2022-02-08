install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)

daily_activity<- read.csv("dailyActivity_merged.csv")
View(daily_activity)

sleep_day<- read.csv("sleepDay_merged.csv")
View(sleep_day)

weight_loginfo<- read.csv("weightLogInfo_merged.csv")
View(weight_loginfo)
#use data of activity and sleep 
#see distinct value of both data
n_distinct(daily_activity$Id)
n_distinct(sleep_day$Id)

Weight<-distinct(weight_loginfo,Id, WeightKg )
View(Weight)

Daily_Activity<- select(daily_activity,Id, TotalDistance, SedentaryMinutes)
View(Daily_Activity)

Sleep<- select(sleep_day,Id, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed)
View(Sleep)

combined<- merge(Daily_Activity, Weight)
View(combined)

combined_full_data<- merge(combined,Sleep)
View(combined_full_data)
#viz 1- distance vs. sleep
ggplot(data=combined_full_data)+
  geom_point(mapping=aes(x=TotalDistance, y=TotalMinutesAsleep,color=TotalMinutesAsleep))+
  geom_smooth(mapping=aes(x=TotalDistance, y=TotalMinutesAsleep),color="purple")+
  labs(title="Relation between Distance covered and Sleep")

#viz2- sedentary vs. weight

ggplot(data=combined_full_data)+
  geom_smooth(mapping=aes(x=SedentaryMinutes, y=WeightKg),color="black")+
  labs(title="Relation between sedentary time and weight of person")+
  geom_point(mapping=aes(x=SedentaryMinutes, y=WeightKg, color=WeightKg))


#viz 3- distance vs. weight
ggplot(data=combined_full_data)+
  geom_smooth(mapping=aes(x=TotalDistance, y=WeightKg),color="black")+
  labs(title="Relation between weight and distance covered daily")
  






