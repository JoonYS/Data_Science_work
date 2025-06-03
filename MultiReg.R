library(ggplot2)
library(tidyverse)
library(dplyr)

# Read in the dataset
ames <- read.csv("ames.csv")

amesRed <- ames %>% 
  filter(Gr.Liv.Area < 4000) %>% 
  select(Gr.Liv.Area, Lot.Area, Overall.Cond, SalePrice)

# Split the data into training and test sets (80/20 split, seed=110)
set.seed(110)
n <- nrow(amesRed)
rnd <- sample(1:n, n * 0.8)
amesTrain <- amesRed[rnd,]
amesTest <- amesRed[-rnd,]

# Fit a multiple regression model on the training set
adModel <- lm(SalePrice ~ Gr.Liv.Area + Lot.Area + Overall.Cond, data = amesTrain)

# Display the summary of the model to assess the fit
summary(adModel)

# Predict SalePrice on the training data
train_pred <- predict(adModel, newdata = amesTrain)

# Predict SalePrice on the test data
test_pred <- predict(adModel, newdata = amesTest)

# Calculate Mean Squared Error and R-squared for training data
train_mse <- mean((amesTrain$SalePrice - train_pred)^2)
train_r2 <- 1 - (sum((amesTrain$SalePrice - train_pred)^2) / sum((amesTrain$SalePrice - mean(amesTrain$SalePrice))^2))

# Calculate Mean Squared Error and R-squared for test data
test_mse <- mean((amesTest$SalePrice - test_pred)^2)
test_r2 <- 1 - (sum((amesTest$SalePrice - test_pred)^2) / sum((amesTest$SalePrice - mean(amesTest$SalePrice))^2))

# Output the evaluation metrics
cat("Training MSE:", train_mse, "\n")
cat("Training R-squared:", train_r2, "\n")
cat("Test MSE:", test_mse, "\n")
cat("Test R-squared:", test_r2, "\n")

# Visualize the training set predictions vs actual values
ggplot(amesTrain, aes(x = SalePrice, y = train_pred)) +
  geom_point(color = 'blue', alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = 'red', linetype = 'dashed') +
  labs(title = "Training Set: Actual vs Predicted SalePrice",
       x = "Actual SalePrice",
       y = "Predicted SalePrice") +
  theme_minimal()

# Visualize the test set predictions vs actual values
ggplot(amesTest, aes(x = SalePrice, y = test_pred)) +
  geom_point(color = 'green', alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = 'red', linetype = 'dashed') +
  labs(title = "Test Set: Actual vs Predicted SalePrice",
       x = "Actual SalePrice",
       y = "Predicted SalePrice") +
  theme_minimal()

