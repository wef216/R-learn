#install.packages("tidyverse")
#install.packages("broom", type="binary")
#install.packages("ggrepel")

library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggrepel)
head(mpg)
str(mpg)


# Figure 1: USING "labs()" layer
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
                               geom_smooth(se = F)  +
                               labs( 
                               x = "Engine displacement (L)",
                               y = "Highway fuel economy (mpg)",
                               color = "Car type",
                               title = paste("Fuel efficiency generally decreases with", "engine size"),
                               subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                               caption = "Data from fueleconomy.gov"
                             )



# Figure 2: USING "geom_label/geom_text" to dispaly annotations
best_in_class <- mpg %>% group_by(class) %>% filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
                               geom_text(aes(label = model), data = best_in_class) +
                                labs( 
                                  x = "Engine displacement (L)",
                                  y = "Highway fuel economy (mpg)",
                                  color = "Car type",
                                  title = paste("Fuel efficiency generally decreases with", "engine size"),
                                  subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                                  caption = "Data from fueleconomy.gov"
                                )

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
                                geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5) +
                                labs( 
                                  x = "Engine displacement (L)",
                                  y = "Highway fuel economy (mpg)",
                                  color = "Car type",
                                  title = paste("Fuel efficiency generally decreases with", "engine size"),
                                  subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                                  caption = "Data from fueleconomy.gov"
                                )


ggplot(mpg, aes(displ, hwy, color = class)) + geom_point() +
                               ggrepel::geom_label_repel(aes(label = model), data = best_in_class) +
                               geom_point(size = 3, shape = 1, data = best_in_class)  +
                                labs( 
                                  x = "Engine displacement (L)",
                                  y = "Highway fuel economy (mpg)",
                                  color = "Car type",
                                  title = paste("Fuel efficiency generally decreases with", "engine size"),
                                  subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                                  caption = "Data from fueleconomy.gov"
                                )


label <- mpg %>% summarize(displ = max(displ), hwy = max(hwy), labels = "Increasing engine size is \nrelated to decreasing fuel economy.")


ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color =  class)) +
                                      geom_text(aes(label = labels), data = label, vjust= "top", hjust = "center") + 
                                      labs( 
                                        x = "Engine displacement (L)",
                                        y = "Highway fuel economy (mpg)",
                                        color = "Car type",
                                        title = paste("Fuel efficiency generally decreases with", "engine size"),
                                        subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                                        caption = "Data from fueleconomy.gov"
                                      ) +
                                      theme(
                                        legend.position = "none"
                                      )


label2 <- tibble(displ = Inf, hwy = Inf, labels = "Increasing engine size is \nrelated to decreasing fuel economy.")


ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color =  class)) +
                                    geom_text(aes(label = labels), data = label, vjust= "top", hjust = "right") + 
                                    labs( 
                                      x = "Engine displacement (L)",
                                      y = "Highway fuel economy (mpg)",
                                      color = "Car type",
                                      title = paste("Fuel efficiency generally decreases with", "engine size"),
                                      subtitle = paste("Two seaters (sports cars) are an exception", "because of their light weight"),
                                      caption = "Data from fueleconomy.gov"
                                    ) +
                                    theme(
                                      legend.position = "none"
                                    )


