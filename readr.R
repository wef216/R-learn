
library(readr)
library(tidyverse)


# read_csv, read_csv2, read_tab, read_delim
# OPTIONS: skip, comment, col_names, na.
read_csv("The first line of metadata 
         The second line of metadata
         x, y , z
         1 ,2 , 3", skip = 2)


read_csv("# The first line of metadata 
          # The second line of metadata
         x, y , z
         1 ,2 , 3", comment = "#", col_names = F)



read_csv("1,2,3\n 4,5,6", col_names = F)


read_csv("1,2,3\n 4,5,6", col_names = c("X", "Y", "Z"))


read_csv("1,2,3\n 4,.,6", col_names = c("X", "Y", "Z"), na = ".")


read_csv("x, y\n1, 'a,b'",  quote = "'")



# parse
# parse_interger, parse_logic, parse_date
parse_integer(c("1", "123", ".", "456"), na = ".")


# the use of locale in parsing the double
parse_double("1.23")

parse_double("1,23", locale = locale(decimal_mark = ","))


parse_number("$100")
parse_number("20%")
parse_number("it costs $123.34")

parse_number("$123,13")
parse_number("$123,13", locale = locale(decimal_mark = ","))

parse_number("123.345.455")
parse_number("123.345.455", locale = locale(grouping_mark = "."))



# parse date, datetime, time
parse_date("January 1, 2010", format = "%B %d, %Y")
parse_date("2015-Mar-07", format = "%Y-%b-%d")
parse_date("06-Jun-2017", format = "%e-%b-%Y")
parse_date(c("August 19 (2015)", "July 1 (2015)"), format = "%B %d (%Y)")
parse_date("12/30/14", format = "%m/%d/%y")
parse_time("1705", format = "%H%M")
parse_time("11:15:10.12 PM", format = "%I:%M:%OS %p")
