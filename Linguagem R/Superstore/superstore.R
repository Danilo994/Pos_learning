data <- read.csv("/mnt/dados/Git/Pos_learning/Linguagem R/Superstore/data/Sample - Superstore.csv", header=TRUE)

str(data)

library(lubridate)
data$Order.Date <- mdy(data$Order.Date)
data$Ship.Date <- mdy(data$Ship.Date)
data$Year = year(data$Order.Date)
data$Month = month(data$Order.Date)
data

which(is.na(data))
colSums(is.na(data))
anyDuplicated(data)