data <- read.csv("/mnt/dados/Git/Pos_learning/Linguagem R/Superstore/data/Sample - Superstore.csv", header=TRUE)

str(data)

library(lubridate)
data$Order.Date <- mdy(data$Order.Date)
data$Ship.Date <- mdy(data$Ship.Date)
data$Year = year(data$Order.Date)
data$Month = month(data$Order.Date)
data$MonthName = month(data$Order.Date, label = TRUE)
data$Order.Weekday = weekdays(data$Order.Date)
data$Ship.Time = as.numeric(data$Ship.Date - data$Order.Date)
data

which(is.na(data))
colSums(is.na(data))
anyDuplicated(data)

library(dplyr)
data %>%
  summarise(
    total_sales = sum(Sales),
    total_profit = sum(Profit),
    avg_sales = mean(Sales),
    avg_profit = mean(Profit),
    total_orders = n()
  )

library(ggplot2)
library(scales)

sales_year <- data %>% group_by(Year) %>% summarise(total_sales = sum(Sales))
ggplot(sales_year, aes(x = Year, y = total_sales)) + 
  geom_line() + 
  geom_point() + 
  geom_text(aes(label = comma(round(total_sales, 0))), vjust = -1) +
  labs(title = "Vendas por ano") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

sales_month <- data %>% group_by(Year, Month) %>% summarise(total_sales = sum(Sales))
ggplot(sales_month, aes(x = Month, y = total_sales, colour = as.factor(Year))) + 
  geom_line() + 
  labs(title = "Vendas por mẽs")

category_sales <- data %>% group_by(Category) %>% summarise(total_sales = sum(Sales), total_profit = sum(Profit))
ggplot(category_sales, aes(x = Category, y = total_sales)) + 
  geom_bar(stat = "identity") + 
  geom_text(aes(label = comma(round(total_sales, 0))), vjust = -0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))
ggplot(category_sales, aes(x = Category, y = total_profit)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = comma(round(total_profit, 0))), vjust = -0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

region_sales <- data %>% group_by(Region) %>% summarise(total_sales = sum(Sales), total_profit = sum(Profit))
ggplot(region_sales, aes(x = Region, y = total_sales)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = comma(round(total_sales, 0))), vjust = -0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))
ggplot(region_sales, aes(x = Region, y = total_profit)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = comma(round(total_profit, 0))), vjust = -0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

ggplot(data, aes(x = Sales, y = Profit)) + 
  geom_point(alpha=0.3)

product_sales <- data %>% 
  group_by(Sub.Category) %>% 
  summarise(total_sales = sum(Sales), total_profit = sum(Profit)) %>% 
  arrange(desc(total_sales))
ggplot(product_sales, aes(x = reorder(Sub.Category, total_sales), y = total_sales)) + 
  geom_bar(stat="identity") + 
  geom_text(aes(label = comma(round(total_sales, 0))), hjust = -0.1) +
  coord_flip() +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

data %>% summarise(avg_shipping_time = mean(Ship.Time))
ggplot(data, aes(x = Ship.Time)) + 
  geom_histogram(binwidth = 1) +
  stat_bin(binwidth = 1, geom = "text", aes(label = comma(..count..)), vjust = -0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))
