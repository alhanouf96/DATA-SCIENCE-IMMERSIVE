#16 Dates and times
library(tidyverse)
library(lubridate)
library(nycflights13)
#16.2.4 Exercises

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

#1- What happens if you parse a string that contains invalid dates?
ymd(c("2010-10-10", "bananas"))

#ANS: [1] "2010-10-10" NA    Warning message: 1 failed to parse. 
#return NA

#2- What does the tzone argument to today() do? Why is it important?
#tzone:	a character vector specifying which time zone you would like to find the current date of.
#tzone defaults to the system time zone set on your computer.

#3- Use the appropriate lubridate function to parse each of the following dates:
d1 <- "January 1, 2010"
mdy(d1)

d2 <- "2015-Mar-07"
ymd(d2)

d3 <- "06-Jun-2017"
dmy(d3)

d4 <- c("August 19 (2015)", "July 1 (2015)")
mdy(d4)

d5 <- "12/30/14" # Dec 30, 2014
mdy(d5)

#16.3.4 Exercises

#1- How does the distribution of flight times within a day change over the course of the year?

flights_dt %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day

#2- Compare dep_time, sched_dep_time and dep_delay. Are they consistent?

#The dep_delay tells us the flights were delayed, but cal_delay tells us the flights departed early.
#The reason is that these delayed flights actually departed on the next day, and were not reflected in dep_time. If we add one day to the dep_time, the results should be consistent.

#3- Compare air_time with the duration between the departure and arrival.

#calculated air time based on arr_time and dep_time are different from the recorded air_time
flights %>%
  mutate(cal_air_time = as.numeric(arr_time - dep_time)) %>%
  select(contains('air_time'))

#4- How does the average delay time change over the course of a day? 

sched_dep <- flights %>% 
  mutate(hour = hour(sched_dep_time)) %>% 
  group_by(hour) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n())

ggplot(sched_dep, aes(hour, avg_delay)) +
  geom_line()

#5- On what day of the week should you leave if you want to minimise the chance of a delay?

flights_dt %>% 
  mutate(wday = wday(dep_time, label = TRUE)) %>% 
  group_by(wday) %>% 
  summarize(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
   )%>%
  gather(key = 'delay', value = 'minutes', 2:3) %>%
  ggplot() +
  geom_col(mapping = aes(x = wday, y = minutes, fill = delay),
           position = 'dodge')

#may Saturdays are the best days to fly

#16.4.5 Exercises

#1- Why is there months() but no dmonths()?
#ANS: may because it's difficult to select day in month unlike wday, also Months do not have a fixed duration in seconds, unlike days, weeks, and years

#2- Explain days(overnight * 1) to someone who has just started learning R. How does it work?

# If arr_time is less than dep_time, then the flight arrives on the next day, and overnight is TRUE;
#otherise, FALSE. Actually, the underlying value of TRUE is 1, and FALSE is 0, so the * 0 can actually be omitted.


#3- Create a vector of dates giving the first day of every month in 2015. Create a vector of dates giving the first day of every month in the current year.

#year2015
datatime<- ymd(20141201)+months(1:12)
datatime

#current year
datatime<-ymd(today()-1)+months(1:12) #  -1 because when i wrote this code, day is 2 oct
datatime

#4- Write a function that given your birthday (as a date), returns how old you are in years.

birthday<-function(y){
  
  your_BirthDay= today()-y
  return(floor(your_BirthDay/dyears(1)))
}

birthday(ymd(19960415))

#5- Why can’t (today() %--% (today() + years(1))) / months(1) work?

#its work :)

