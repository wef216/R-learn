

## Data Transformation with dplyr

# <Prerequisites>
library(dplyr)
library(nycflights13)
library(ggplot2)
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

  
  

  
  
# <Select Columns/Variables with select() >
# syntax: input(dataframe) --> output(dataframe)
#         year:day --> select variables from year to day
#         -(year:day) --> drop variables from year to day
#         common selection helpers: 
#                     starts_with(), ends_with(), contains(), matches(), num_range(), everything(), all_of(), any_of()
#         never modify the input data frame   
  
  
# select the dep_time, dep_delay, arr_time, and arr_delay
  flights %>%
    select(dep_time, dep_delay, arr_time, arr_delay)  #version 1
  
  flights %>%
    select(starts_with(c("dep_", "arr_")))   #version 2
  
  flights %>%
    select(ends_with(c("_time", "_delay")) & !starts_with(c("sched_", "air_")))   #version 2  
  
 # including a variable multiple times
  flights %>%
    select(dep_time, dep_time)

  flights %>%
    select(depTime1 = dep_time, depTime2 = dep_time)
  
  
  # modify the case ingnorance
  select(flights, contains("TIME"))
  select(flights, contains("TIME", ignore.case = F))
  
  # with everything() -- used to put some variable front and keep all other variables.
  select(flights, sched_dep_time, sched_arr_time, everything())
  
  
  # one_of() selection helper
  vars <- c("year", "month", "day", "dep_delay", "arr_delay")
  select(flights, any_of(vars))
  
  
  
  
#< Add New Variables with mutate() & transmute>
# syntax: input(dataframe) --> output(dataframe)
#         never modify the input data frame 
# mutate() creates a new variable and put it to the end of the remainning variables
# transmute() creates a new variablea and keep only the new variables.
  
  # find the most delayed flights
  flights %>%
    mutate(delay_rank = min_rank(dep_delay)) %>%
    arrange(desc(delay_rank))  #version 1
  
  
  flights %>%
    slice_max(dep_delay,n = 10)    #version 2
  
  
    
#< Grouped Summaries with Summarize() >  
# It collapses a data frame to a single row.
# input: a data frame
# it is commonly used with group_by() function  
# then perform function in the grouped units level
  
?summarize  
  summarize(flights, delay = mean(dep_delay, na.rm = T))
  
  # Calculate the mean of delay by year, month, day.
  by_day <- group_by(flights, year, month, day)
  summarize(by_day, delay = mean(dep_delay, na.rm = T))   # version 1
  
  flights %>% group_by(year, month, day) %>% summarize(delay = mean(dep_delay, na.rm = T)) # version 2
  
  
  # correlation between dist and delay
  delays <- flights %>% 
              group_by(dest) %>% 
              summarize(count = n(), 
                        dist = mean(distance, na.rm = T),
                        delay = mean(arr_delay, na.rm = T)
                        ) %>%
              filter(count > 20, dest != "HNL")
  
  ggplot(delays, aes(dist, delay)) + geom_point(aes(size = count), alpha = 1/3) + geom_smooth(se = F)

  
  
# < Missing Values >
# The rule of missing values: if there is any missing values in the input, the output of the aggregation function will be a missing value
# All aggregation functions have an na.rm option
  
  # Remove the cancelled flights
  not_cancelled <- flights %>% 
    filter(!is.na(arr_delay), !is.na(dep_delay))
  
  flights %>% 
    filter(!is.na(arr_delay) & !is.na(dep_delay))
  
# < Counts >
# a count number : n()
# a count of nonmissing values (sum!(is.na()))
  
  # identify the flights having the highest average delays
  delays <- not_cancelled %>% 
    group_by(tailnum) %>%
    summarize(delay = mean(arr_delay), n = n())
    
ggplot(delays, aes(delay)) + geom_freqpoly(binwidth = 10)
    
ggplot(delays, aes(n, delay)) + geom_point(alpha = 1/10)  

delays %>% filter(n > 25) %>% ggplot(aes(n, delay)) + geom_point(alpha = 1/10)  


# < Grouping by Multiple Variables >
# when grouping by multiple variables, each summary peels off one level of the grouping,
# by default, peel off from the last one in the group_by 
    daily <- group_by(flights, year, month, day)
    (per_day <- summarize(daily, flights = n()))
    (per_month <- summarize(per_day, flights = sum(flights)))
    
    daily <- group_by(flights, day, month, year)
    (per_day <- summarize(daily, flights = n()))
    (per_month <- summarize(per_day, flights = sum(flights)))

    
?ungroup    
    
vignette("window-functions")    
    


# Brainstorm Exercises
# A flight is 15 mins early 50% of the time and 15 mins late 50% of the time
  flights %>% 
    group_by(tailnum) %>%
    summarize(
      count = n(),
      early = sum(arr_delay <= -15) / count,
      later = sum(arr_delay >= 15) / count
    ) %>%
    filter(early == 0.5, later == 0.5)
  
# A flight is always 10 mins later
  flights %>%
    group_by(tailnum) %>%
    summarize(
      count = n(),
      later_10min = sum(arr_delay >= 10)
    ) %>%
    filter(count == later_10min)

# A flight is 30 mins early 50% of the time and 30mins late 50% of the time
  flights %>% 
    group_by(tailnum) %>%
    summarize(
      count = n(),
      early = sum(arr_delay <= -30) / count,
      later = sum(arr_delay >= 30) / count
    ) %>%
    filter(early == 0.5, later == 0.5)
  
 # 99% of the time the flight is on time and 1% of the time it is 2 hours late
  flights %>%
    group_by(tailnum) %>%
    summarize(
      count = n(),
      onTime = sum(arr_delay <= 0),
      later_2h = sum(arr_delay >= 120)
    ) %>%
    filter(onTime/count == 0.99, later_2h/count == 0.01)

  
  
  # number of destinations in the non-cancelled flights
  not_cancelled %>% count(dest)  # version 1
  
  not_cancelled %>% group_by(dest) %>% summarize(count = n())  # version 2
  
  # number of tailnum weighted by distance
  not_cancelled %>% count(tailnum, wt = distance)   # version 1
  
  not_cancelled %>% group_by(tailnum) %>% summarize(n = sum(distance))  
  
  
  