library(dplyr)

vehicles_filtered <- vehicles %>%
  filter(Drive == "Rear-Wheel Drive" & year > 2015) %>%
  summarise(
    mean_citympg = mean(citympg, na.rm = TRUE),
    sd_citympg = sd(citympg, na.rm = TRUE),
    count = n()
  )

fuel_eff <- vehicles %>%
  filter(cylinders == 4 & highwaympg >= 40) %>%
  select(year, make, model, highwaympg, co2emissions)
fuel_eff

top_10_fuel_eff <- fuel_eff %>%
  arrange(desc(highwaympg)) %>%
  slice(1:10) %>%
  select(make, model, highwaympg)
top_10_fuel_eff

avg_citympg_transmission <- vehicles %>%
  group_by(transmission) %>%
  summarise(average_citympg = mean(citympg, na.rm = TRUE))
avg_citympg_transmission

avg_mpg_diff_2018 <- vehicles %>%
  filter(year == 2018) %>%
  summarise(avg_difference = mean(highwaympg - citympg, na.rm = TRUE))
avg_mpg_diff_2018