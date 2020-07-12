

## Data Transformation with dplyr

# <Prerequisites>
library(dplyr)
library(nycflights13)

flights #view the data

# <Filter Rows with filter()> : 
# syntax: input(dataframe) --> output(dataframe)
#         never modify the input data frame

# select all flights on January 1st
flights %>% filter(month == 1 , day == 1)
# select all flights in Nov, and Dec
flights %>% fliter(month == 11 |month == 12)  # version 1
flights %>% filter(month %in% c(11,12)) # version 2



