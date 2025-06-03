library(ggplot2)

data("diamonds")

#1
ggplot(diamonds, aes(x = clarity, fill = cut)) +
  geom_bar(position = "dodge") +
  labs(title = "Bar Plot of Clarity Shaded by Cut") +
  theme_minimal() +
  theme(legend.position = "top right")

#2
ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Price Filled by Cut") +
  theme_minimal() +
  theme(legend.position = "top right")

#3
ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot() +
  labs(title = "Box Plot of Price by Color") +
  theme_minimal()

#4
ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot() +
  facet_wrap(~clarity, ncol = 2) +
  labs(title = "Box Plot of Price by Color, Faceted by Clarity") +
  theme_minimal()
#5
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Scatter Plot of Carat by Price with Regression Line") +
  theme_minimal()