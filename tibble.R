library(tidyverse)

tibble(x = 1:5, y = 1, z = x^2 + y)

# tibble never converts strings to factors, never changes the name of the variables, never creates row names.

# tibble can have nonsyntatic names
tb <- tibble(`:)`= "smile", ` ` = "space", `2000` = "number")
tb


# transposed tibble for customized data entry
tribble(
   ~x, ~y, ~z, 
   
   "a", 2, 3.6,
   "b", 1, 8.5
)


# over view the tibble without accidentally overwhelm the console
nycflights13 :: flights

nycflights13 :: flights %>% print(n = 20, width = Inf)


df <- data.frame(abc = 1, xyz = "a")
df$x    # the traditional data frame does the partial matching across the names.
class(df[, "xyz"])
class(df[, c("abc", "xyz")])

tb <- tibble(abc = 1, xyz = "a")
tb$x     #tibble does not do the partial matching.

