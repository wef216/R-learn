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
                                    geom_text(aes(label = labels), data = label2, vjust= "top", hjust = "right") + 
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




ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color =  class)) +
                                    annotate("text", x = 6, y = 40, label = "Increasing engine size is \nrelated to decreasing fuel economy") + 
                                    annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28, colour = "red", size = 1.5)  +
                                    annotate("segment", x = 2.5, xend = 4, y = 15, yend = 25, colour = "blue")  +
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



# Figure 3: scale

ggplot(mpg, aes(displ, hwy)) + geom_point()

ggplot(mpg, aes(displ, hwy)) + geom_point() + scale_y_continuous(breaks = seq(15,40, by = 5))

ggplot(mpg, aes(displ, hwy)) + geom_point() + scale_y_continuous(breaks = seq(15,40, by = 5), labels = NULL)



presidential %>% mutate(id = 33 + row_number())   %>% ggplot(aes(start, id)) + geom_point() + 
          geom_segment(aes(xend = end, yend = id)) + 
          scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")


presidential %>% mutate(id = 33 + row_number())   %>% ggplot(aes(start, id)) + geom_point() + 
  geom_segment(aes(xend = end, yend = id, color = party)) + 
  scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y") +
  scale_color_manual(
    values = c(Republican = "red", Democratic = "blue")
  )



install.packages("scales")
library(scales)
presidential %>% mutate(id = 33 + row_number())   %>% ggplot(aes(start, id)) + geom_point() + 
  geom_segment(aes(xend = end, yend = id)) + 
  scale_x_date(NULL, breaks = presidential$start, labels = date_format("%y"))




df <- expand.grid(X1 = 1:10, X2 = 1:10)
df$value <- df$X1 * df$X2

p1 <- ggplot(df, aes(X1, X2)) + geom_tile(aes(fill = value))
p1
p2 <- p1 + geom_point(aes(size = value))
p2
p1 + scale_fill_continuous(guide = guide_legend())
p1 + guides(fill = guide_legend(title = "LEFT", title.position = "left"))

p1 + guides(fill =
              guide_legend(
                title.theme = element_text(
                  size = 15,
                  face = "italic",
                  colour = "red",
                  angle = 0
                )
              )
)


dat <- data.frame(x = 1:5, y = 1:5, p = 1:5, q = factor(1:5), r = factor(1:5))
p <- ggplot(dat, aes(x, y, colour = p, size = q, shape = r)) + geom_point()
p

p + guides(colour = "colorbar", size = "legend", shape = "legend")

p +
  scale_colour_continuous(guide = "colorbar") +
  scale_size_discrete(guide = "legend") +
  scale_shape(guide = "legend")

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(size = hwy, colour = cyl, shape = drv)) +
  guides(
    colour = guide_colourbar(order = 1),
    shape = guide_legend(order = 2),
    size = guide_legend(order = 3)
  )


ggplot(diamonds, aes(log10(carat), log10(price))) +
  geom_bin2d()


ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))


ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "Set1")










