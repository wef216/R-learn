# Create a data set: Leadership
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, NA, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age,
                         q1, q2, q3, q4, q5, stringsAsFactors=FALSE)



###DATA WRANGLE

# create variables
leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age < 55] <- "Young"
summary(factor(leadership$agecat, levels = c("Elder", "Middle Aged", "Young"), order = T))


leadership <- within(leadership, {
                        agecat2 <- NA
                        agecat2[age > 75] <- "Elder"
                        agecat2[age <=75] <- "Middle Aged"
                        agecat2[age < 55] <- "Young" }
                  )

summary(factor(leadership$agecat2, levels = c("Elder", "Middle Aged", "Young"), order = T))
leadership$agecat2 <- as.factor(leadership$agecat2)
summary(leadership)


#rename variables
fix(leadership)

names(leadership)
colnames(leadership)
names(leadership)[2] <- "testData"
colnames(leadership)[2] <- "testDate"
names(leadership)[6:10] <- paste0("item",1:5)

install.packages("plyr")
library(plyr)
leadership <- rename(leadership, c("mangerID" = "managerID"))


y <- with(leadership, {y = sum(item4, na.rm =T)})
y


leadership_clean <- na.omit(leadership)
leadership_clean_q4 <- leadership[!is.na(leadership$item4), ]



# Date Value
leadership$testDate <- as.Date(leadership$testDate, '%m/%d/%y')

  
today <- Sys.Date()
dob <- as.Date("1991-05-21")
myAge <- today - dob
myAge
difftime(today, dob, units = "hours")
format(today, "%y")



# sort the data
leadership <- leadership[order(leadership$age), ]

clear
