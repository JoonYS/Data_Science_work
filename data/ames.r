library(dplyr)
home <- read.csv("ames.csv")

filtered <- home %>%
  filter(Year.Built <1960, Neighborhood %in% c("BrkSide", "OldTown", "Somerst"),
         SalePrice <85000,
         Overall.Cond < 5,
         Gr.Liv.Area / Lot.Area < 0.25) %>%
  select(PID, SalePrice, Neighborhood, Year.Built, Overall.Cond) %>%
  arrange(desc(Overall.Cond))

write.table(filtered, "filtered_homes_list.txt", sep = "\t", row.names = FALSE)

head(filtered)

