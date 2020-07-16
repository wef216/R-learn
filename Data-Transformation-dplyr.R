

## Data Transformation with dplyr

# <Prerequisites>
library(dplyr)
library(nycflights13)

flights #view the data

# <Filter Rows with filter()> : 
# syntax: input(dataframe) --> output(dataframe)
#         never modify the input data frame

# filter all flights on January 1st
flights %>% filter(month == 1 , day == 1)
# filter  all flights in Nov, and Dec
flights %>% fliter(month == 11 |month == 12)  # version 1
flights %>% filter(month %in% c(11,12)) # version 2

# filter all flights that were not delayed (arrival or departure) by more than 2 hours
flights %>% filter(!(arr_time > 120 | dep_time > 120))  #version 1
flights %>% filter(arr_time <= 120 & dep_time <= 120 ) #version 2

# find all flights that:
  #1) had a arrival delay of two or more hours
  filter(flights, arr_delay >=120)
  #2) flew to hourston
  filter(flights, dest %in% c("HOU", "IAH")) #version 1
  filter(flights, dest == "HOU" | dest == "IAH") #version 2
  #3) were operated by UA or Delta
  filter(flights, carrier %in% c("UA", "Delta"))
  #4) departed in summer (July, August, September)
  filter(flights, month %in% c(7,8,9))
  #5) arrived more than 2 hours later but did not leave late
  filter(flights, dep_delay == 0 & arr_delay >= 120)
  #6) were delayed by at least an hour, but made up over 30 mins in flight
  filter(flights, dep_delay >= 60 & arr_delay <= 30)
  #7) departed between midnight and 6 am 
  filter(flights, dep_time >= 1 & dep_time <= 6)
  
  
# Betwen function
  filter(flights, between(dep_time, 1,6))
  
# number of flights with missing depart time
  sum(is.na(flights$dep_time))

  
  
  
  
  
# <Arrange Rows with arrange() >
# syntax: input(dataframe) --> output(dataframe)
#         option: desc() to reorder in desccending order  
#         never modify the input data frame  

# sort all missing values to the start
  flights %>%
    arrange(desc(is.na(dep_time)))

# find the most delayed flights
  flights %>%
    arrange(desc(dep_delay))
# find the fastest flgiht
  flights %>%
    arrange(air_time)
# find the flights travelling the longest distance  
  flights %>%
    arrange(desc(distance))         # version 1
   
  flights[which.max(flights$distance),]   #version 2

  