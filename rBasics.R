# 1
a <- 2.3
result <- (6 * a + 42) / (3)^(4.2 - 3.62)
result  # Should return approximately 29.50556

# 2
b <- (3^2 * 4^(1/8)) / 2.33
b

# 3
c <- -8.2 * 10^(-13)
c

# 4
result_b_c <- b / c
result_b_c

# 5
v1 <- c(23, 32, 67, 12, 19, 40, 18, 45)

# Step 6: Return the 3rd value of v1
third_value_v1 <- v1[3]
third_value_v1

# 7
v2 <- v1^2 - 15
v2

# 8
mean_v2 <- mean(v2)
sd_v2 <- sd(v2)
mean_v2
sd_v2

# 9
df <- data.frame(v1 = v1, v2 = v2)
df

# 10
v1_greater_than_35 <- v1[v1 > 35]
v1_greater_than_35

# Step 11: Add a logical vector 'v3' to 'df' that is TRUE for every value of 'v1' that is an even number
v3 <- v1 %% 2 == 0
df$v3 <- v3
df

# Step 12: Return every value in 'v1' that is an even number
even_values_v1 <- v1[v1 %% 2 == 0]
even_values_v1
