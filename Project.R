# Load necessary libraries
library(ggplot2)
library(dplyr)

census_data <- read.csv("census_data.csv")
vehicles <- read.csv("vehicles.csv")

# 1. Income by Race Over Years Bar Plot
census_data$race <- factor(census_data$race, levels = c("White", "Black", "Asian", "Hispanic"), ordered = TRUE)
ggplot(census_data, aes(x = race, y = Income, fill = factor(year))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Income by Race Over Years", x = "Race", y = "Income (USD)", fill = "Year") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 2. EPA Emissions Histogram
ggplot(vehicles, aes(x = co2emissions)) +
  geom_histogram(binwidth = 50, fill = "skyblue", color = "black") +
  labs(title = "EPA Emissions", x = "CO2 Emissions", y = "Frequency")

# 3. EPA Emissions Histogram with Normal Distribution
ggplot(vehicles, aes(x = co2emissions)) +
  geom_histogram(aes(y = ..density..), binwidth = 50, fill = "skyblue", color = "black") +
  stat_function(fun = dnorm, args = list(mean = mean(vehicles$co2emissions), sd = sd(vehicles$co2emissions)), color = "red", size = 1) +
  labs(title = "EPA Emissions with Normal Distribution", x = "CO2 Emissions", y = "Density")

# 4. EPA Emissions Density Plot with Normal Distribution
ggplot(vehicles, aes(x = co2emissions)) +
  geom_density(fill = "gray", alpha = 0.5) +
  stat_function(fun = dnorm, args = list(mean = mean(vehicles$co2emissions), sd = sd(vehicles$co2emissions)), color = "red", size = 1) +
  labs(title = "EPA Emissions - Density", x = "CO2 Emissions", y = "Density")

# 5. Car Class Bar Plot
ggplot(vehicles, aes(x = class)) +
  geom_bar(fill = "lightblue", color = "black") +
  labs(title = "Car Class", x = "Class", y = "Count")

# 6. Car Class by Cylinders Stacked Bar Plot
ggplot(vehicles, aes(x = class, fill = factor(cylinders))) +
  geom_bar(position = "stack") +
  labs(title = "Car Class by Cylinders", x = "Class", y = "Count", fill = "Cylinders")

# 7. CO2 Emissions by Car Class Boxplot
ggplot(vehicles, aes(x = class, y = co2emissions)) +
  geom_boxplot(fill = "lightgreen") +
  geom_hline(yintercept = mean(vehicles$co2emissions), color = "red", linetype = "dashed", size = 1) +
  labs(title = "CO2 Emissions by Car Class", x = "Car Class", y = "CO2 Emissions")

# 8. CO2 Emissions vs Highway MPG Scatter Plot with Linear Regression Line
ggplot(vehicles, aes(x = highwaympg, y = co2emissions)) +
  geom_point(shape = 4, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 1.5) +
  labs(title = "CO2 Emissions vs Highway MPG", x = "Highway MPG", y = "CO2 Emissions")

# 9. Scatter Plot with Smoothed Spread for CO2 Emissions vs Highway MPG (Using car package)
scatterplot(co2emissions ~ highwaympg, data = vehicles,
            smoother = TRUE, spread = TRUE, pch = 4,
            main = "CO2 Emissions vs Highway MPG with Smoothed Spread",
            col = "blue", smoother.col = "red")

