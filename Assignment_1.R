daily <-
  read.csv(file = 'daily.csv', header = TRUE)

# 1
daily$day_of_week <- factor(daily$day_of_week,
                            levels=c ("Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"))
table(daily$day_of_week)


# 2
weekday <- daily[daily$day_of_week %in% c("Mon", "Tues", "Wed", "Thurs", "Fri"), ] 
weekend <- daily[daily$day_of_week %in% c("Sat", "Sun"), ]

# 3 
#alternatemethod 
#cold <- weekend$month %in% c("Sat","Sun")
#winterRiders <- weekend$n_riders[cold]
#hist(winterRiders)

winter_weekend <- daily[daily$day_of_week %in% c("Sat", "Sun") & daily$month %in% c("Jan", "Feb", "Mar"), ]
winterRiders <- winter_weekend$n_riders

#customized the histogram
hist(winterRiders, main="Winter Weekend Riders", xlab="Number of Riders", col="blue", border="black")

# 4
#rowNum <- 1:nrow(daily)
#evenNum <- rowNum %% 2 == 0
#even <- daily[evenNum,]
#odd <- daily[!evenNum,]

even_rows <- daily[seq(2, nrow(daily), 2), ]
odd_rows <- daily[seq(1, nrow(daily), 2), ]

# 5
set.seed(440)

train_index <- sample(1:nrow(daily), 0.6 * nrow(daily))

# Split the data into train and test sets
train <- daily[train_index, ]

test <- daily[-train_index, ]


View(train)
View(test)
