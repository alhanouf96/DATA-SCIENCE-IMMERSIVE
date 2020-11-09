# Heuristic Models
# Look at the Seattle weather in the data folder. 
# Come up with a heuristic model to predict if it will rain today. 
# Keep in mind this is a time series, which means that you only know what happened historically (before a given date). 
# One example of a heuristic model is: It will rain tomorrow if it rained more than 1 inch (>1.0 PRCP) today. 
# Describe your heuristic model in the next cell.

# Your model here:


#It will rain tomorrow if it rained more than 0.7 inch (>0.7 PRCP) today


# Here is an example of how to build and populate a hurestic model:

df <- seattle_weather_1948_2017
df[is.na(df)]<-0

# Create an empty dataframe
heuristic_df1<-data.frame(matrix(, nrow=nrow(df)-2, ncol=0))
heuristic_df1$Yesterday<-0
heuristic_df1$Today<-0
heuristic_df1$Tomorrow<-0
heuristic_df1$Guess<-FALSE
heuristic_df1$Rain_tomorrow<-FALSE
heuristic_df1$Correct<-FALSE

# View first 10 rows of each dataframe
head(df, 10)
head(heuristic_df1, 10)

# Build a loop to add your heuristic model guesses as a column to this dataframe

# Here is an example loop that populates the dataframe created earlier
# with the total percip from yesterday and today
# then the guess is set to true if rained both yesterday and today 

for(z in seq(1,nrow(df)-2,1)) {
  #start at time 2 in the data frame
  i <- z + 2
  
  #pull values from the dataframe
  yesterday <- df[(i-2),2]
  today <- df[(i-1),2]
  tomorrow <- df[i,2]
  rain_tomorrow <- tomorrow>0
  
  heuristic_df1[z,1] <- yesterday
  heuristic_df1[z,2] <- today
  heuristic_df1[z,3] <- tomorrow
  heuristic_df1[z,4] <- FALSE # set guess default to False
  heuristic_df1[z,5] <- rain_tomorrow
  
 
  if (today > 0.7){
    heuristic_df1[z,4] = TRUE
  }
  
  if(heuristic_df1[z,4] == heuristic_df1[z,5])  heuristic_df1[z,6] <- TRUE
  else heuristic_df1[z,6] <- FALSE
}



#Evaluate the performance of the Heuristic model
#the accuracy of your predicitions

sum(heuristic_df$Correct)/nrow(heuristic_df)
