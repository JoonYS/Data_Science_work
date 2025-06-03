# Load required libraries
library(tidyverse)
library(class)    
library(caret)    
library(MASS)     

# Load the Iris dataset
data("iris")

# Standardize the four features (Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
iris_scaled <- iris %>%
  mutate(across(Sepal.Length:Petal.Width, scale))

# Set seed and create an 80/20 train-test split
set.seed(123)
train_index <- createDataPartition(iris_scaled$Species, p = 0.8, list = FALSE)
train_data <- iris_scaled[train_index, ]
test_data <- iris_scaled[-train_index, ]

# Function to evaluate KNN for different values of k
evaluate_knn <- function(k, train_data, test_data) {
  predictions <- knn(train = train_data[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")],
                     test = test_data[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")],
                     cl = train_data$Species, k = k)
  accuracy <- mean(predictions == test_data$Species)
  return(accuracy)
}

# Testing different values of k (from 1 to 20)
k_values <- 1:20
accuracy_values <- sapply(k_values, function(k) evaluate_knn(k, train_data, test_data))

# Finding the best k
best_k <- k_values[which.max(accuracy_values)]
best_k_accuracy <- max(accuracy_values)
cat("Best k:", best_k, "with accuracy:", best_k_accuracy, "\n")

# Plotting k vs. accuracy to visualize performance
plot(k_values, accuracy_values, type = "b", col = "blue",
     xlab = "k", ylab = "Accuracy", main = "Accuracy for Different k Values in KNN")

# Evaluate KNN with reduced features
# Only Sepal measurements (Sepal.Length, Sepal.Width)
evaluate_knn_reduced <- function(k, train_features, test_features, train_labels, test_labels) {
  predictions <- knn(train = train_features, test = test_features, cl = train_labels, k = k)
  accuracy <- mean(predictions == test_labels)
  return(accuracy)
}

accuracy_sepal <- evaluate_knn_reduced(
  best_k,
  train_features = train_data[, c("Sepal.Length", "Sepal.Width")],
  test_features = test_data[, c("Sepal.Length", "Sepal.Width")],
  train_labels = train_data$Species,
  test_labels = test_data$Species
)

accuracy_petal <- evaluate_knn_reduced(
  best_k,
  train_features = train_data[, c("Petal.Length", "Petal.Width")],
  test_features = test_data[, c("Petal.Length", "Petal.Width")],
  train_labels = train_data$Species,
  test_labels = test_data$Species
)

cat("Accuracy with Sepal measurements only:", accuracy_sepal, "\n")
cat("Accuracy with Petal measurements only:", accuracy_petal, "\n")

# LDA Model for comparison
lda_model <- lda(Species ~ ., data = train_data)
lda_predict <- predict(lda_model, newdata = test_data)
lda_predictions <- lda_predict$class

# Confusion Matrix and Accuracy for LDA
lda_conf_matrix <- confusionMatrix(lda_predictions, test_data$Species)
lda_accuracy <- lda_conf_matrix$overall['Accuracy']
cat("LDA Accuracy:", lda_accuracy, "\n")

# Plot LDA decision boundaries (LD1 and LD2)
lda_scores <- cbind(test_data, lda_predict$x)
ggplot(data = lda_scores, aes(x = LD1, y = LD2)) +
  geom_point(aes(color = Species)) +
  ggtitle("LDA Decision Boundaries")

# Final Comparison Summary
cat("Comparison Summary:\n")
cat("Best KNN Accuracy (with best k =", best_k, "):", best_k_accuracy, "\n")
cat("KNN Accuracy with Sepal features only:", accuracy_sepal, "\n")
cat("KNN Accuracy with Petal features only:", accuracy_petal, "\n")
cat("LDA Accuracy:", lda_accuracy, "\n")

