

# < load the Data Set >
states.data <- readRDS("Rstatistics/dataSets/states.rds")

states.info <- data.frame(attributes(state.data)[c("names", "var.labels")])

tail(state.info, 8)



# < Linear Regression >
sts.ex.sat <- subset(states.data, select = c("expense", "csat"))
summary(sts.ex.sat)

# correlation between expense and csat
cor(sts.ex.sat)

# plot the data 
plot(sts.ex.sat)



# fit linear regression model
sat.md <- lm(csat ~ expense,    # regression formula
             data = states.data)   # data set

# summarize and print the results
summary(sat.md)

# fit 2nd linear regression model
sat.md2 <- lm(csat ~ expense + percent,    # regression formula
             data = states.data)   # data set
summary(lm(csat ~ expense + percent,    # regression formula 
                data = states.data))    # data set


# < The lm Class and Mehtod >

# sat.md is a model object
class(sat.md)
typeof(sat.md)

names(sat.md)

methods(class = class(sat.md))[1:9]

# confidence interval
confint(sat.md2, "expense")

anova(sat.md2)

alias(sat.md2)

hist(residuals(sat.md2))



#< Visualize the Linear Regression Assumptions >
par(mar = c(4,4,2,2), mfrow = c(1,2))
plot(sat.md2, which = c(1,2))



# comparing models
sat.voting.md <- lm(csat ~ expense + house + senate,
                    data = na.omit(states.data))

sat.md2 <- update(sat.md2, data = na.omit(states.data))



# < Model with Interactions >
sat.expense.by.income <- lm(csat ~ expense * income,
                             data = states.data)

sat.expense.by.percent <- lm(csat ~ expense * income*percent,
                             data = states.data)

summary(sat.expense.by.percent)


# < Regression with Factors >
typeof(states.data$region)

lm(csat ~ region, data = states.data)

states.data$region <- factor(states.data$region)
sat.region <- lm(csat ~ region, data = states.data)
coef(summary(sat.region))


 # setting factor reference groups and contrast
contrasts(states.data$region)  #west is the contrast

coef(summary(lm(csat ~ C(region, base = 1), data = states.data)))

coef(summary(lm(csat ~ C(region, contr.helmert), data = states.data)))


?contr.helmert



# < Ligistic Regression: glm() >
# < load the Data Set >
NH11 <- readRDS("Rstatistics/dataSets/NatHealth2011.rds")
labs <- attributes(NH11)$labels

str(NH11$hypev)
str(NH11$bmi)

NH11$hypev <- factor(NH11$hypev, levels = c("2 No", "1 Yes"))

str(NH11$hypev)

hyp.out <- glm(hypev~ age_p + sex + sleep + bmi, 
               data = NH11, 
               family = "binomial")

summary(hyp.out)
coef(hyp.out)
hyp.out.tab <- coef(summary(hyp.out))
hyp.out.tab[, "Estimate" ] <- exp(coef(hyp.out))
hyp.out.tab

hyp.out.tab[, "Estimate" ] <- exp(hyp.out.tab[, "Estimate"])
hyp.out.tab

?expand.grid
predData <- with(NH11, 
          expand.grid(
            age_p = c(33,53),
            sex = "2 Female",
            bmi = mean(bmi, na.rm = T),
            sleep = mean(sleep, na.rm = T)
          ))


?predict

cbind(predData, predict(hyp.out, newdata = predData, type = "response", se.fit = T, interval = 'confidence'))


install.packages("effects")
library(effects)
plot(allEffects(hyp.out))
?effectsTheme
