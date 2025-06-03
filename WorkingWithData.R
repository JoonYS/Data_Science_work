# Managing Data with R

#----------------------------------------------------------------
#' #1. Loading Data - CSV
#----------------------------------------------------------------
# Change your working directory by specifying the path to the desired folder
# setwd("~/OneDrive - Butler University/DS310/class/data")

# Load the data and use the `col_types` argument to specify type of 
# all columns('n' stands for numerical and 'f' stands for factor).

setwd("~/DS310/")
vehicles <-
  read.csv(file = 'vehicles.csv', header = TRUE) #default
vehicles2 <- 
  read.csv (file = "https://blue.butler.edu/~rpadgett/DS310/data/vehicles.csv")

#can be from a web page....
grad <- 
  read.csv (file = "https://blue.butler.edu/~rpadgett/DS310/data/grad_admit.csv")

head(vehicles, 5) # or 
vehicles[1:5,]
tail (vehicles, 5) #or
start <- nrow(vehicles)-4
end <-nrow(vehicles)
vehicles[start:end,2:4]

View (vehicles)
str(vehicles) # See the structure - tidyverse - glimpse

#Referencing the data in a dataframe by name or position
mean(vehicles$highwaympg, na.rm = TRUE) # remove missing data
mean(vehicles$highwaympg[1:200], na.rm = TRUE) # rnow it's a vector

mean(vehicles[,5], na.rm = TRUE) # every row, on column 5 (highwaympg)

# Referencing parts of a dataframe
mean(vehicles[1:200,5], na.rm = TRUE)
smallData <- vehicles[1:10,c(2,4,6)] #so what does this do?

# Filtering observation from a dataframe
#Get a dataframe of the Nissan vehicles
nissan <- vehicles[vehicles$make=="Nissan" & vehicles$year > 2016,]
nissan$model




#----------------------------------------------------------------
#  Creating Sequences, Random Numbers, and Random Samples
#----------------------------------------------------------------

# creating sequences

x <- 1:10
y <- seq(from = 10, to = 100, by = 10)
z <- seq(100,1,-2)

# creating psudo-random numbers

set.seed (123) # for the seed for the next call of any random function
x <- runif(50) # random uniform between 0 and 1
y <- trunc(runif(1000000, min=1,max=7),0) #let's roll some dice
table(y)

z <- rbinom(1000, 1, .8) #1000 binomial values of 1 trial each with probability = .8 
table (z)
z <- rbinom(10000000, 16, .5) #Let's flip some coins! - Buzz and Doris approved!
table(z)

x <- rnorm(1000, mean=100, sd=15) #normal distribution
cbind('mean' = mean(x), 'sd' = sd(x)) #column bind
hist(x)

#----------------------------------------------------------------
# Let's work with grad Data
#----------------------------------------------------------------

grad <- 
  read.csv (file = "https://blue.butler.edu/~rpadgett/DS310/data/grad_admit.csv")

table (grad$admit)
grad$admit <- factor(grad$admit, levels = c(0,1), labels = c("No","Yes"))
table (grad$admit)

grad$grade <- cut (grad$gpa, breaks = c(-Inf,1.999,2.999,Inf),
                   labels = c("F","B","A"))
summary (grad)
table (grad$grade)   

y <- sample (grad$gre, 10, replace = FALSE)
z <- sample (grad$gre, 800, replace=TRUE) # turns out this is very useful!
cbind('mean' = mean(z), 'sd' = sd(z)) #column bind

#Let' divide grad into two set, train and test using sample

#add a column of row numbers to the vehicles dataframe
n = nrow(grad)
grad <- cbind.data.frame('id' = 1:n,grad) #remember this trick, but it's dangerous!

set.seed(1234)
rnd <- sample(1:n, n*.8, replace=FALSE) #create a sequence of row numbers
rnd <- sort(rnd)

train <- grad[rnd,] #specifies the rows in rnd and take all variables
test <- grad[-rnd,]
View(train)
View(test)
