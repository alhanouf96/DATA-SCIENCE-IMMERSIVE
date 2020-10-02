library(tidyverse)
library(nycflights13)
library(dplyr)
###Exercises in Ch 12 ###
#12.2.1 Exercises
#1- Using prose, describe how the variables and observations are organised in each of the sample tables.

#ANS: already explained in a video at Tidy section

#2- Compute the rate for table2, and table4a + table4b

#table2
countries<- filter(table2, type=='cases')$country
years<- filter(table2, type=='cases')$year
cases<- filter(table2, type=='cases')$count
populations<- filter(table2, type=='population')$count
table2Rate<-tibble(country=countries,
                   year=years,
                   rate=cases/populations*10000
)
table2Rate

#table4a + table4b

countries<- table4a$country
cases_1999<-table4a$'1999'
cases_2000<-table4a$'2000'
population_1999<-table4b$'1999'
population_2000<-table4b$'2000'

table1999_Rate<- tibble(country=countries,
                        year=1999,
                        reat=cases_1999/population_1999*10000 )

table2000_Rate<- tibble(country=countries,
                        year=2000,
                        reat=cases_2000/population_2000*10000 )

table4Rate<- rbind(table1999_Rate,table2000_Rate)%>% arrange(country)

table4Rate

#table2 is easier to work with, and involves less steps.

#3- Recreate the plot showing change in cases over time using table2 instead of table1

table2%>% filter(type=='cases')%>%
  ggplot(aes(year, count)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))+
  scale_x_continuous(breaks = unique(table2$year))+
  ylab("cases")

#12.3.3 Exercises
#1- Why are pivot_longer() and pivot_wider() not perfectly symmetrical?

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

#The functions `pivot_longer()` and `pivot_wider()` are not perfectly symmetrical because column type information is lost when a data frame is converted from wide to long.
#These column names will always be treated as `character` values by `pivot_longer()` so if the original variable used to create the column names did not have a `character` data type, then the round-trip will not reproduce the same dataset.

#2- Why does this code fail?
table4a %>% 
  pivot_longer(c('1999':'2000'), names_to = "year", values_to = "cases") #missing a backticks around the num of year and :

#3- What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?
#ANS: Spreading this tibble will fail because there are duplicated rows #age with 45 and 50

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
#add a new column to uniquely identify each value
people$id <- c(1, 1, 2, 1, 1)
people
#  dropping duplicate rows
people %>%
  distinct(name, names, .keep_all = TRUE) %>%
  pivot_wider(names_from="name", values_from = "values")

#4- Tidy the simple tibble below. Do you need to make it wider or longer? What are the variables?
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg %>%
  pivot_longer(c(`male`,`female`),names_to = 'gender', values_to = 'value', 2:3)

#12.4.3 Exercises
#1- What do the extra and fill arguments do in separate()? Experiment with the various options for the following two toy datasets.
#extra controls what happens when the separated pieces are more than the number of variables defined
# The default option is warn
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra="warp" )

#The option drop drops extra pieces without giving a warning
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra="drop" )

#extra values are not split
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra="merge" )

#The option right fills with NAs on the right without a warning.
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = 'right')

#The option left fills with NAs on the left.
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"),fill = 'left')

#2- Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?

#ANS: Its set TRUE by default, remove input columns from output data frame.
#If set to FALSE, the original separate column, or the united columns, are retained in the output.

#In table5, the century and year columns are united as new, but are still in the output
table5 %>% 
  unite(new, century, year, sep = "", remove = FALSE)

#3- Compare and contrast separate() and extract(). Why are there three variations of separation (by position, by separator, and with groups), but only one unite?

#ANS: 
"'''with `extract()` and `separate()` only one column can be chosen,
but there are many choices how to split that single column into different columns.
With `unite()`, there are many choices as to which columns to include, but only one 
choice as to how to combine their contents into a single vector.'''"

#12.5.1 Exercises

#1- Compare and contrast the fill arguments to pivot_wider() and complete().

#ANS:
#pivot_wider() increasing the number of columns and decreasing the number of rows.
#complete() Turns implicit missing values into explicit missing values

#fill argument in `pivot_wider()` and the `fill` argument to `complete()` both set vales to replace `NA`. 

#2- What does the direction argument to fill() do?

#The default value is down. Any NAs will be replaced by the previous non-missing value. The filling direction can be reversed if .direction is set to up.

###Exercises in Ch 13 ###

#13.2.1 Exercises

#1- Imagine you wanted to draw (approximately) the route each plane flies from its origin to its destination. What variables would you need? What tables would you need to combine?

#This requires the `flights` and `airports` tables.
#The `flights` table has the origin (`origin`) and destination (`dest`) airport of each flight.
#The `airports` table has the longitude (`lon`) and latitude (`lat`) of each airport.

#2- I forgot to draw the relationship between weather and airports. What is the relationship and how should it appear in the diagram?

#ANS: The column `airports$faa` is a foreign key of `weather$origin`.

#3- weather only contains information for the origin (NYC) airports. If it contained weather records for all airports in the USA, what additional relation would it define with flights?
#ANS: it would provide the weather for the destination of each flight.
#The `weather` data frame columns (`year`, `month`, `day`, `hour`, `origin`) are a foreign key for the `flights` data frame columns (`year`, `month`, `day`, `hour`, `dest`).
#4- We know that some days of the year are “special”, and fewer people than usual fly on them. How might you represent that data as a data frame? What would be the primary keys of that table? How would it connect to the existing tables?

#We can create a new table special containing the pertaining information of the special dates. To match special with the exisiting tables, the keys would be year, month, and day.


#13.3.1 Exercises

#1 Add a surrogate key to flights.
flights$surrogate<- c(1:336776)

#2- Identify the keys in the following datasets

#The primary keys for babynames::babynames are year, sex, and name

babynames::babynames %>%
  group_by(year, sex, name) %>%
  mutate(n = n()) %>%
  filter(n > 1) %>%
  nrow()

#The primary keys for fueleconomy::vehicles are id

########
flights %>% 
  count(year, month, day, tailnum) %>% 
  filter(n > 1)

#The primary keys for nasaweather::atoms are lat, long, year and month
nasaweather::atmos %>%
  group_by(lat, long, year,month) %>%
  mutate(n = n()) %>%
  filter(n > 1) %>%
  nrow()

#The primary keys for Lahman::Batting are playerID, yearID, teamID,lgID and stint
Lahman::Batting %>%
  group_by(playerID, yearID, teamID,lgID,stint) %>%
  mutate(n = n()) %>%
  filter(n > 1) %>%
  nrow()


#13.4.6 Exercises

#1- Compute the average delay by destination, then join on the airports data frame so you can show the spatial distribution of delays. 


flights %>% group_by(dest) %>%
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airports, by = c('dest' = 'faa')) %>%
  ggplot(aes(x = lon, y = lat, size = avg_arr_delay, color = avg_arr_delay)) +
  borders('state') +
  geom_point() +
  coord_quickmap()

#2- Add the location of the origin and destination (i.e. the lat and lon) to flights.

flights%>% 
  left_join(airports, by=c('dest'='faa'))%>%
  left_join(airports, by=c('origin'='faa'), suffix=c('.dest','.origin'))%>%
  select(dest,origin,contains('lat'),contains('lon'))

#3- Is there a relationship between the age of a plane and its delays?

flights %>% group_by(tailnum) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE),
            avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  gather(key = 'mode', value = 'delay', 2:3) %>%
  left_join(planes, by = 'tailnum') %>%
  ggplot(mapping = aes(x = year, y = delay)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_grid(.~mode)
# May they is no relationship between delays and year of a plane.

#4- What weather conditions make it more likely to see a delay?

flights %>% 
  left_join(weather, by = c('year','month','day','hour','origin')) %>%
  gather(key = 'condition', value = 'value', temp:visib) %>%
  filter(!is.na(dep_delay)) %>%
  ggplot(mapping = aes(x = value, y = dep_delay)) +
  geom_point() +
  facet_wrap(~condition, ncol = 3, scale = 'free_x')

#May they is no relationship between departure delay and  weather condition

#5 What happened on June 13 2013? Display the spatial pattern of delays?

flights %>% filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airports, by = c('dest' = 'faa')) %>%
  ggplot(aes(x = lon, y = lat, size = avg_arr_delay, color = avg_arr_delay)) +
  borders('state') +
  geom_point(alpha = .5) +
  scale_color_continuous(low = 'yellow', high = 'red') + 
  coord_quickmap()


#13.5.1 Exercises

#1- What does it mean for a flight to have a missing tailnum? What do the tail numbers that don’t have a matching record in planes have in common? 
#ANS:flight that have a missing tailnum are those that were cancellled
flights %>%
  filter(is.na(tailnum) )

# those tailnum that don’t have a matching record in plane, it seems most of them come from the same two carriers

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(carrier, sort = TRUE)

#2- Filter flights to only show flights with planes that have flown at least 100 flights.

planes_gte100 <- flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum) %>%
  count() %>%
  filter(n >= 100)
flights %>%
semi_join(planes_gte100, by = "tailnum")


#3- Combine fueleconomy::vehicles and fueleconomy::common to find only the records for the most common models.

fueleconomy::vehicles %>%
  semi_join(fueleconomy::common, by = c('make', 'model'))


#4- What does anti_join(flights, airports, by = c("dest" = "faa")) tell you? What does anti_join(airports, flights, by = c("faa" = "dest")) tell you?

#ANS: first one  shows flight whose destinations are not included in the airports 
#the second hows airport names and locations that flights from flights are not flying to


