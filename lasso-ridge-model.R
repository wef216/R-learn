

install.packages("glmnet")
install.packages("Matrix")
set.seed(123)

library(glmnet)
library(Matrix)
library(dplyr)
library(psych)

data("mtcars")


# Center y, X will be standardized in the modelling function
y <- mtcars %>% select(mpg) %>% scale(center = TRUE, scale = FALSE) %>% as.matrix()
x <- mtcars %>% select(-mpg) %>% as.matrix()



## RIDGE REGRESSION 

# Perform 10-fold cross-validation to select lambda ---------------------------
lambdas_to_try <- 10^seq(-3,5,length.out = 100)

# Setting alpha = 0 implements ridge regression
ridge_cv <- cv.glmnet(x, y, alpha = 0, lambda = lambdas_to_try, standardize = T, nfolds = 10)

ridge_cv

# Plot cross-validation results
plot(ridge_cv)

# Best cross-validated lambda
lambda_cv <- ridge_cv$lambda.min


# Fit final model, get its sum of squared residuals and multiple R-squared
model_cv <- glmnet(x, y, alpha = 0, lambda = lambda_cv, standardize = T)

y_hat_cv <- predict(model_cv, x)

ssr_cv <- t(y - y_hat_cv) %*% (y - y_hat_cv)
rsq_ridge_cv <- cor(y, y_hat_cv)^2




## LASSO REGRESSION


                    