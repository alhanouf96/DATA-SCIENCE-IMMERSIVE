# Heuristic Models (Cost Function Extension)
############################################################
# Look at the seattle weather in the data folder.
# Come up with a heuristic model to predict if
# it will rain today. Keep in mind this is a time series,
# which means that you only know what happened 
# historically (before a given date). One example of a
# heuristic model is: it will rain tomorrow if it rained
# more than 1 inch (>1.0 PRCP) today. Describe your heuristic
# model here


#############################################################
##################### It will rain tomorrow if it rained more than 0.7 inch (>0.7 PRCP) today.#######################
#############################################################
# Examples:
# if it rained yesterday it will rain today
# if it rained yesterday or the day before, it will rain today
# Here is an example of how to build and populate 
# a heuristic model

library(tidyverse)

df <- seattle_weather_1948_2017

numrow = 25549
heuristic_df <- data.frame("Yesterday" = 0,
                           "Today" = 0,
                           "Tomorrow" = 0,
                           "Guess" = FALSE,
                           "Rain_Tomorrow" = FALSE,
                           "Correct" = FALSE,
                           "True_Positive" = FALSE,
                           "False_Positive" = FALSE,
                           "True_Negative" = FALSE,
                           "False_Negative" = FALSE)

# #pull values from the dataframe

df$PRCP = ifelse(is.na(df$PRCP),
                 ave(df$PRCP, FUN = function(x) mean(x, na.rm = TRUE)),
                 df$PRCP)
for (z in 1:numrow){
  i = z + 2
  yesterday = df[i-2,2]
  today = df[i-1,2]
  tomorrow = df[i,2]
  if (tomorrow == 0){
    rain_tomorrow = FALSE
  }
  else{
    rain_tomorrow = TRUE
  }
  heuristic_df[z,1] = yesterday
  heuristic_df[z,2] = today
  heuristic_df[z,3] = tomorrow
  heuristic_df[z,4] = FALSE # Label all guesses as false
  heuristic_df[z,5] = rain_tomorrow
  heuristic_df[z,7] = FALSE
  heuristic_df[z,8] = FALSE
  heuristic_df[z,9] = FALSE
  heuristic_df[z,10] = FALSE
  
  # Now let's populate our heuristic model guessess
  
  if (today > 0.7){
    heuristic_df[z,4] = TRUE
  }
  if (heuristic_df[z,4] == heuristic_df[z,5]){
    heuristic_df[z,6] = TRUE
    if (heuristic_df[z,4] == TRUE){
      heuristic_df[z,7] = TRUE #true positive
    }else{
      heuristic_df[z,9] = TRUE #True negative
    }
  }else{
    heuristic_df[z,6] = FALSE
    if (heuristic_df[z,4] == TRUE){
      heuristic_df[z,7] = TRUE #false positive
    }else{
      heuristic_df[z,9] = TRUE #false negative
    }
  }
}



# Split data into training and testing

#use caTools function to split, SplitRatio for 70%:30% splitting
data1= sample.split(heuristic_df,SplitRatio = 0.3)

#subsetting into Train data
train =subset(heuristic_df,data1==TRUE)

#subsetting into Test data
test =subset(heuristic_df,data1==FALSE)


# Calculate the accuracy of your predictions
# we used this simple approach in the first part to see what percent of the time we where correct
# calculated as (true positive + true negative)/ number of guesses


accuracy_of_predicitions  = nrow(subset(heuristic_df, Correct==TRUE))/numrow
accuracy_of_predicitions


# Calculate the precision of your prediction
# precision is the percent of your postive prediction which are correct
# more specifically it is calculated (num true positive)/(num true positive + num false positive)

true_positive=nrow(subset(heuristic_df, True_Positive==TRUE))
false_positive=nrow(subset(heuristic_df, False_Positive==TRUE))
precision= true_positive/true_positive+false_positive
precision

# Calculate the recall of your predictions
# recall the percent of the time you are correct when you predict positive
# more specifically it is calculated (num true positive)/(num tru positive + num false negative)

False_Negative=nrow(subset(heuristic_df, False_Negative==TRUE))
recall_precision= true_positive/true_positive+False_Negative
recall_precision


# The sum of squared error (SSE) of your predictions

squared_errors=sum(heuristic_df['Rain_Tomorrow']-heuristic_df['Guess']**2)
squared_errors
