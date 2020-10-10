library(tidyverse)
#dataset source: http://training.theodi.org/resources/dataset2.csv


' This dataset is very messy, there is a lot of missing and random data,
in the -Unique Project ID- there are values that do not fit the rest in the column,
also there are negative number values in the cost columns '

"' I've learned that the cleaning is very important, as I faced a problem with the lack of clarity of the plot,
and later I found that's due to the negative values'"


view(dataset2)
head(dataset2)

newDataSet <-dataset2


#Tidy data

#1A- Dealing with the missing values in important columns
#I've use fill () It takes a set of columns where you want missing values to be replaced by the most recent non-missing value 

newDataSet<- newDataSet %>% 
  fill("Planned Project Completion")%>% 
  fill("Projected/Actual Project Completion") 


#1B- Dealing with the missing and random values via 
#I've use na.omit() to drop all random\NA values

newDataSet<-na.omit(newDataSet)


#2- Pivoting Longer
#all variables of costs in single variable

newDataSet <- pivot_longer(data = newDataSet, 
                       cols = 'Lifecycle Cost':'Projected/Actual Cost ($ M)',
                       names_to = "Type_of_Costs",
                       values_to = "Costs")

#3- Dealing with negative values
#I've use abs() to convert all negative values to absolute values

newDataSet$Costs<-abs(newDataSet$Costs)


#4- Ranking of categorical variables
#I've use ordered() to convert certain columns to become ordinal, So that its values can be known independently

newDataSet$`Type_of_Costs` <- ordered(newDataSet$"Type_of_Costs")
newDataSet$`Project Name` <- ordered(newDataSet$`Project Name` )
newDataSet$`Investment Title`<- ordered(newDataSet$`Investment Title`)


#Exploratory Data Analysis


#Review projects and their cost
ggplot(data = newDataSet) +
  geom_point(mapping = aes(x = `Project Name`, y = `Costs`))

#Review Investment and their cost
ggplot(data = newDataSet) +
  geom_point(mapping = aes(x = `Investment Title`, y = `Costs`))


ggplot(data = newDataSet, mapping = aes(x = `Costs`, colour = Project_Name)) +
  geom_freqpoly(binwidth = 0.1)





